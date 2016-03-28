// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/compositor_engine.h"

#include <algorithm>
#include <sstream>
#include <utility>

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "base/time/time.h"
#include "mojo/services/gfx/composition/cpp/formatting.h"
#include "mojo/skia/type_converters.h"
#include "services/gfx/compositor/backend/gpu_output.h"
#include "services/gfx/compositor/graph/snapshot.h"
#include "services/gfx/compositor/render/render_frame.h"
#include "services/gfx/compositor/renderer_impl.h"
#include "services/gfx/compositor/scene_impl.h"

namespace compositor {
namespace {
// TODO(jeffbrown): Determine and document a more appropriate size limit
// for viewports somewhere.  May be limited by the renderer output.
const int32_t kMaxViewportWidth = 65536;
const int32_t kMaxViewportHeight = 65536;

std::string SanitizeLabel(const mojo::String& label) {
  return label.get().substr(0, mojo::gfx::composition::kLabelMaxLength);
}
}  // namespace

CompositorEngine::CompositorEngine() : weak_factory_(this) {}

CompositorEngine::~CompositorEngine() {}

mojo::gfx::composition::SceneTokenPtr CompositorEngine::CreateScene(
    mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene_request,
    const mojo::String& label) {
  auto scene_token = mojo::gfx::composition::SceneToken::New();
  scene_token->value = next_scene_token_value_++;
  CHECK(scene_token->value);
  CHECK(!FindScene(scene_token->value));

  // Create the state and bind implementation to it.
  SceneState* scene_state =
      new SceneState(scene_token.Pass(), SanitizeLabel(label));
  SceneImpl* scene_impl =
      new SceneImpl(this, scene_state, scene_request.Pass());
  scene_state->set_scene_impl(scene_impl);
  base::Closure error_handler =
      base::Bind(&CompositorEngine::OnSceneConnectionError,
                 base::Unretained(this), scene_state);
  scene_impl->set_connection_error_handler(error_handler);

  // Add to registry.
  scenes_by_token_.insert({scene_state->scene_token()->value, scene_state});
  DVLOG(1) << "CreateScene: scene=" << scene_state;
  return scene_state->scene_token()->Clone();
}

void CompositorEngine::OnSceneConnectionError(SceneState* scene_state) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(1) << "OnSceneConnectionError: scene=" << scene_state;

  DestroyScene(scene_state);
}

void CompositorEngine::DestroyScene(SceneState* scene_state) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(1) << "DestroyScene: scene=" << scene_state;

  // Unlink from other scenes.
  for (auto& pair : scenes_by_token_) {
    SceneState* other_scene_state = pair.second;
    other_scene_state->scene_def()->UnlinkReferencedScene(
        scene_state->scene_def(),
        base::Bind(&CompositorEngine::SendResourceUnavailable,
                   base::Unretained(this),
                   base::Unretained(other_scene_state)));
  }

  // Destroy any renderers using this scene.
  for (auto& renderer : renderers_) {
    if (renderer->root_scene() == scene_state) {
      LOG(ERROR) << "Destroying renderer whose root scene has become "
                    "unavailable: renderer="
                 << renderer;
      DestroyRenderer(renderer);
    }
  }

  // Destroy.
  InvalidateScene(scene_state);

  // Remove from registry.
  scenes_by_token_.erase(scene_state->scene_token()->value);
  delete scene_state;
}

void CompositorEngine::CreateRenderer(
    mojo::InterfaceHandle<mojo::ContextProvider> context_provider,
    mojo::InterfaceRequest<mojo::gfx::composition::Renderer> renderer_request,
    const mojo::String& label) {
  DCHECK(context_provider);
  uint32_t renderer_id = next_renderer_id_++;
  CHECK(renderer_id);

  // Create the state and bind implementation to it.
  RendererState* renderer_state =
      new RendererState(renderer_id, SanitizeLabel(label));
  RendererImpl* renderer_impl =
      new RendererImpl(this, renderer_state, renderer_request.Pass());
  renderer_state->set_renderer_impl(renderer_impl);
  renderer_impl->set_connection_error_handler(
      base::Bind(&CompositorEngine::OnRendererConnectionError,
                 base::Unretained(this), renderer_state));

  // Create the renderer.
  SchedulerCallbacks scheduler_callbacks(
      base::Bind(&CompositorEngine::OnOutputUpdateRequest,
                 weak_factory_.GetWeakPtr(), renderer_state->GetWeakPtr()),
      base::Bind(&CompositorEngine::OnOutputSnapshotRequest,
                 weak_factory_.GetWeakPtr(), renderer_state->GetWeakPtr()));
  std::unique_ptr<Output> output(new GpuOutput(
      context_provider.Pass(), scheduler_callbacks,
      base::Bind(&CompositorEngine::OnOutputError, weak_factory_.GetWeakPtr(),
                 renderer_state->GetWeakPtr())));
  renderer_state->set_output(std::move(output));

  // Add to registry.
  renderers_.push_back(renderer_state);
  DVLOG(1) << "CreateRenderer: " << renderer_state;
}

void CompositorEngine::OnRendererConnectionError(
    RendererState* renderer_state) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DVLOG(1) << "OnRendererConnectionError: renderer=" << renderer_state;

  DestroyRenderer(renderer_state);
}

void CompositorEngine::DestroyRenderer(RendererState* renderer_state) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DVLOG(1) << "DestroyRenderer: renderer=" << renderer_state;

  // Remove from registry.
  renderers_.erase(
      std::find(renderers_.begin(), renderers_.end(), renderer_state));
  delete renderer_state;
}

void CompositorEngine::SetListener(
    SceneState* scene_state,
    mojo::gfx::composition::SceneListenerPtr listener) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(1) << "SetSceneListener: scene=" << scene_state;

  scene_state->set_scene_listener(listener.Pass());
}

void CompositorEngine::Update(SceneState* scene_state,
                              mojo::gfx::composition::SceneUpdatePtr update) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(1) << "Update: scene=" << scene_state << ", update=" << update;

  scene_state->scene_def()->EnqueueUpdate(update.Pass());
}

void CompositorEngine::Publish(
    SceneState* scene_state,
    mojo::gfx::composition::SceneMetadataPtr metadata) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(1) << "Publish: scene=" << scene_state << ", metadata=" << metadata;

  if (!metadata)
    metadata = mojo::gfx::composition::SceneMetadata::New();
  int64_t presentation_time = metadata->presentation_time;
  scene_state->scene_def()->EnqueuePublish(metadata.Pass());

  // Implicitly schedule fresh snapshots.
  InvalidateScene(scene_state);

  // Ensure that the scene will be presented eventually, even if it is
  // not associated with any renderer.  Note that this is only a backstop
  // in case the scene does not get presented sooner as part of snapshotting
  // a renderer.  Note that scenes which are actually visible will be
  // snapshotted by the renderer when it comes time to draw the next frame,
  // so this special case is only designed to help with scenes that are
  // not visible to ensure that we will still apply pending updates which
  // might have side-effects on the client's state (such as closing the
  // connection due to an error or releasing resources).
  MojoTimeTicks now = MojoGetTimeTicksNow();
  DCHECK(now >= 0);
  if (presentation_time <= now) {
    SceneDef::Disposition disposition = PresentScene(scene_state, now);
    if (disposition == SceneDef::Disposition::kFailed)
      DestroyScene(scene_state);
  } else {
    base::MessageLoop::current()->PostDelayedTask(
        FROM_HERE, base::Bind(&CompositorEngine::OnPresentScene,
                              weak_factory_.GetWeakPtr(),
                              scene_state->GetWeakPtr(), presentation_time),
        base::TimeDelta::FromMicroseconds(presentation_time - now));
  }
}

void CompositorEngine::ScheduleFrame(SceneState* scene_state,
                                     const SceneFrameCallback& callback) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));

  scene_state->AddSceneFrameCallback(callback);

  // TODO(jeffbrown): Be more selective and do this work only for scenes
  // which are strongly associated with the renderer so it doesn't receive
  // conflicting timing signals coming from multiple renderers.
  for (auto& renderer : renderers_) {
    ScheduleFrameForRenderer(renderer,
                             Scheduler::SchedulingMode::kUpdateAndSnapshot);
  }
}

void CompositorEngine::SetRootScene(
    RendererState* renderer_state,
    mojo::gfx::composition::SceneTokenPtr scene_token,
    uint32 scene_version,
    mojo::RectPtr viewport) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DCHECK(scene_token);
  DCHECK(viewport);
  DVLOG(1) << "SetRootScene: renderer=" << renderer_state
           << ", scene_token=" << scene_token
           << ", scene_version=" << scene_version << ", viewport=" << viewport;

  if (viewport->width <= 0 || viewport->width > kMaxViewportWidth ||
      viewport->height <= 0 || viewport->height > kMaxViewportHeight) {
    LOG(ERROR) << "Invalid viewport size: " << viewport;
    DestroyRenderer(renderer_state);
    return;
  }

  // Find the scene.
  SceneState* scene_state = FindScene(scene_token->value);
  if (!scene_state) {
    LOG(ERROR) << "Could not set the renderer's root scene, scene not found: "
                  "scene_token="
               << scene_token;
    DestroyRenderer(renderer_state);
    return;
  }

  // Update the root.
  if (renderer_state->SetRootScene(scene_state, scene_version, *viewport)) {
    ScheduleFrameForRenderer(renderer_state,
                             Scheduler::SchedulingMode::kSnapshot);
  }
}

void CompositorEngine::ClearRootScene(RendererState* renderer_state) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DVLOG(1) << "ClearRootScene: renderer=" << renderer_state;

  // Update the root.
  if (renderer_state->ClearRootScene()) {
    ScheduleFrameForRenderer(renderer_state,
                             Scheduler::SchedulingMode::kSnapshot);
  }
}

void CompositorEngine::HitTest(
    RendererState* renderer_state,
    mojo::PointFPtr point,
    const mojo::gfx::composition::HitTester::HitTestCallback& callback) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DCHECK(point);
  DVLOG(1) << "HitTest: renderer=" << renderer_state << ", point=" << point;

  auto result = mojo::gfx::composition::HitTestResult::New();

  if (renderer_state->visible_snapshot()) {
    DCHECK(!renderer_state->visible_snapshot()->is_blocked());
    renderer_state->visible_snapshot()->HitTest(*point, result.get());
  }

  callback.Run(result.Pass());
}

base::WeakPtr<SceneDef> CompositorEngine::ResolveSceneReference(
    const mojo::gfx::composition::SceneToken& scene_token) {
  SceneState* scene_state = FindScene(scene_token.value);
  return scene_state ? scene_state->scene_def()->GetWeakPtr()
                     : base::WeakPtr<SceneDef>();
}

void CompositorEngine::SendResourceUnavailable(SceneState* scene_state,
                                               uint32_t resource_id) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(2) << "SendResourceUnavailable: resource_id=" << resource_id;

  // TODO: Detect ANRs
  if (scene_state->scene_listener()) {
    scene_state->scene_listener()->OnResourceUnavailable(
        resource_id, base::Bind(&base::DoNothing));
  }
}

SceneState* CompositorEngine::FindScene(uint32_t scene_token) {
  auto it = scenes_by_token_.find(scene_token);
  return it != scenes_by_token_.end() ? it->second : nullptr;
}

void CompositorEngine::InvalidateScene(SceneState* scene_state) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(2) << "InvalidateScene: scene=" << scene_state;

  for (auto& renderer : renderers_) {
    if (renderer->current_snapshot() &&
        renderer->current_snapshot()->HasDependency(scene_state->scene_def())) {
      ScheduleFrameForRenderer(renderer, Scheduler::SchedulingMode::kSnapshot);
    }
  }
}

SceneDef::Disposition CompositorEngine::PresentScene(
    SceneState* scene_state,
    int64_t presentation_time) {
  DCHECK(IsSceneStateRegisteredDebug(scene_state));
  DVLOG(2) << "PresentScene: scene=" << scene_state;

  std::ostringstream errs;
  SceneDef::Disposition disposition = scene_state->scene_def()->Present(
      presentation_time, base::Bind(&CompositorEngine::ResolveSceneReference,
                                    base::Unretained(this)),
      base::Bind(&CompositorEngine::SendResourceUnavailable,
                 base::Unretained(this), base::Unretained(scene_state)),
      errs);
  if (disposition == SceneDef::Disposition::kFailed) {
    LOG(ERROR) << "Scene published invalid updates: scene=" << scene_state;
    LOG(ERROR) << errs.str();
    // Caller is responsible for destroying the scene.
  }
  return disposition;
}

void CompositorEngine::PresentRenderer(RendererState* renderer_state,
                                       int64_t presentation_time) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DVLOG(2) << "PresentRenderer: renderer_state=" << renderer_state;

  // TODO(jeffbrown): Be more selective and do this work only for scenes
  // associated with the renderer that actually have pending updates.
  std::vector<SceneState*> dead_scenes;
  for (auto& pair : scenes_by_token_) {
    SceneState* scene_state = pair.second;
    SceneDef::Disposition disposition =
        PresentScene(scene_state, presentation_time);
    if (disposition == SceneDef::Disposition::kFailed)
      dead_scenes.push_back(scene_state);
  }
  for (SceneState* scene_state : dead_scenes)
    DestroyScene(scene_state);
}

void CompositorEngine::SnapshotRenderer(
    RendererState* renderer_state,
    const mojo::gfx::composition::FrameInfo& frame_info) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  DVLOG(2) << "SnapshotRenderer: renderer_state=" << renderer_state;

  if (VLOG_IS_ON(2)) {
    std::ostringstream block_log;
    SnapshotRendererInner(renderer_state, &block_log);
    if (!renderer_state->current_snapshot() ||
        renderer_state->current_snapshot()->is_blocked()) {
      DVLOG(2) << "Rendering completely blocked: " << block_log.str();
    } else if (!block_log.str().empty()) {
      DVLOG(2) << "Rendering partially blocked: " << block_log.str();
    } else {
      DVLOG(2) << "Rendering unblocked";
    }
  } else {
    SnapshotRendererInner(renderer_state, nullptr);
  }

  if (renderer_state->visible_snapshot()) {
    DCHECK(!renderer_state->visible_snapshot()->is_blocked());
    renderer_state->output()->SubmitFrame(
        renderer_state->visible_snapshot()->CreateFrame(
            renderer_state->root_scene_viewport(), frame_info));
  } else {
    renderer_state->output()->SubmitFrame(RenderFrame::CreateEmpty(
        renderer_state->root_scene_viewport().To<SkIRect>(), frame_info));
  }
}

void CompositorEngine::SnapshotRendererInner(RendererState* renderer_state,
                                             std::ostream* block_log) {
  if (!renderer_state->root_scene()) {
    if (block_log)
      *block_log << "No root scene" << std::endl;
    renderer_state->SetSnapshot(nullptr);
    return;
  }

  SnapshotBuilder builder(block_log);
  renderer_state->SetSnapshot(
      builder.Build(renderer_state->root_scene()->scene_def()));
}

void CompositorEngine::ScheduleFrameForRenderer(
    RendererState* renderer_state,
    Scheduler::SchedulingMode scheduling_mode) {
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));
  renderer_state->output()->GetScheduler()->ScheduleFrame(scheduling_mode);
}

void CompositorEngine::OnOutputError(
    const base::WeakPtr<RendererState>& renderer_state_weak) {
  RendererState* renderer_state = renderer_state_weak.get();
  if (!renderer_state)
    return;
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));

  LOG(ERROR) << "Renderer encountered a fatal error: renderer="
             << renderer_state;

  DestroyRenderer(renderer_state);
}

void CompositorEngine::OnOutputUpdateRequest(
    const base::WeakPtr<RendererState>& renderer_state_weak,
    const mojo::gfx::composition::FrameInfo& frame_info) {
  RendererState* renderer_state = renderer_state_weak.get();
  if (!renderer_state)
    return;
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));

  // TODO(jeffbrown): Be more selective and do this work only for scenes
  // associated with the renderer.
  for (auto& pair : scenes_by_token_) {
    pair.second->DispatchSceneFrameCallbacks(frame_info);
  }
}

void CompositorEngine::OnOutputSnapshotRequest(
    const base::WeakPtr<RendererState>& renderer_state_weak,
    const mojo::gfx::composition::FrameInfo& frame_info) {
  RendererState* renderer_state = renderer_state_weak.get();
  if (!renderer_state)
    return;
  DCHECK(IsRendererStateRegisteredDebug(renderer_state));

  PresentRenderer(renderer_state, frame_info.presentation_time);
  SnapshotRenderer(renderer_state, frame_info);
}

void CompositorEngine::OnPresentScene(
    const base::WeakPtr<SceneState>& scene_state_weak,
    int64_t presentation_time) {
  SceneState* scene_state = scene_state_weak.get();
  if (!scene_state)
    return;
  DCHECK(IsSceneStateRegisteredDebug(scene_state));

  SceneDef::Disposition disposition =
      PresentScene(scene_state, presentation_time);
  if (disposition == SceneDef::Disposition::kFailed)
    DestroyScene(scene_state);
  else if (disposition == SceneDef::Disposition::kSucceeded)
    InvalidateScene(scene_state);
}

}  // namespace compositor
