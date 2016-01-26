// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/view_manager/view_registry.h"

#include <algorithm>
#include <utility>

#include "base/bind.h"
#include "base/bind_helpers.h"
#include "mojo/services/ui/views/cpp/formatting.h"
#include "services/ui/view_manager/view_host_impl.h"
#include "services/ui/view_manager/view_tree_host_impl.h"

namespace view_manager {

static bool AreViewLayoutParamsValid(const mojo::ui::ViewLayoutParams* params) {
  return params && params->constraints && params->constraints->min_width >= 0 &&
         params->constraints->max_width >= params->constraints->min_width &&
         params->constraints->min_height >= 0 &&
         params->constraints->max_height >= params->constraints->min_height &&
         params->device_pixel_ratio > 0;
}

ViewRegistry::ViewRegistry(mojo::gfx::composition::CompositorPtr compositor)
    : compositor_(compositor.Pass()) {}

ViewRegistry::~ViewRegistry() {}

void ViewRegistry::ConnectAssociates(
    mojo::ApplicationImpl* app_impl,
    const std::vector<std::string>& urls,
    const AssociateConnectionErrorCallback& connection_error_callback) {
  associate_table_.ConnectAssociates(app_impl, this, urls,
                                     connection_error_callback);
}

mojo::ui::ViewTokenPtr ViewRegistry::RegisterView(
    mojo::ui::ViewPtr view,
    mojo::InterfaceRequest<mojo::ui::ViewHost> view_host_request,
    const mojo::String& label) {
  DCHECK(view);

  auto view_token = mojo::ui::ViewToken::New();
  view_token->value = next_view_token_value_++;
  CHECK(view_token->value);
  CHECK(!FindView(view_token->value));

  // Create the state and bind host to it.
  std::string sanitized_label =
      label.get().substr(0, mojo::ui::kLabelMaxLength);
  ViewState* view_state =
      new ViewState(view.Pass(), view_token.Pass(), sanitized_label);
  ViewHostImpl* view_host =
      new ViewHostImpl(this, view_state, view_host_request.Pass());
  view_state->set_view_host(view_host);
  view_state->set_view_connection_error_handler(
      base::Bind(&ViewRegistry::OnViewConnectionError, base::Unretained(this),
                 view_state));
  view_host->set_view_host_connection_error_handler(
      base::Bind(&ViewRegistry::OnViewConnectionError, base::Unretained(this),
                 view_state));

  // Add to registry and return token.
  views_by_token_.insert({view_state->view_token()->value, view_state});
  DVLOG(1) << "RegisterView: view=" << view_state;
  return view_state->view_token()->Clone();
}

void ViewRegistry::OnViewConnectionError(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "OnViewConnectionError: view=" << view_state;

  UnregisterView(view_state);
}

void ViewRegistry::UnregisterView(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "UnregisterView: view=" << view_state;

  // Remove from parent or roots.
  HijackView(view_state);

  // Remove from registry.
  views_by_token_.erase(view_state->view_token()->value);
  delete view_state;
}

mojo::ui::ViewTreeTokenPtr ViewRegistry::RegisterViewTree(
    mojo::ui::ViewTreePtr view_tree,
    mojo::InterfaceRequest<mojo::ui::ViewTreeHost> view_tree_host_request,
    const mojo::String& label) {
  DCHECK(view_tree);

  auto view_tree_token = mojo::ui::ViewTreeToken::New();
  view_tree_token->value = next_view_tree_token_value_++;
  CHECK(view_tree_token->value);
  CHECK(!FindViewTree(view_tree_token->value));

  // Create the state and bind host to it.
  std::string sanitized_label =
      label.get().substr(0, mojo::ui::kLabelMaxLength);
  ViewTreeState* tree_state = new ViewTreeState(
      view_tree.Pass(), view_tree_token.Pass(), sanitized_label);
  ViewTreeHostImpl* tree_host =
      new ViewTreeHostImpl(this, tree_state, view_tree_host_request.Pass());
  tree_state->set_view_tree_host(tree_host);
  tree_state->set_view_tree_connection_error_handler(
      base::Bind(&ViewRegistry::OnViewTreeConnectionError,
                 base::Unretained(this), tree_state));
  tree_host->set_view_tree_host_connection_error_handler(
      base::Bind(&ViewRegistry::OnViewTreeConnectionError,
                 base::Unretained(this), tree_state));

  // Add to registry.
  view_trees_by_token_.insert(
      {tree_state->view_tree_token()->value, tree_state});
  DVLOG(1) << "RegisterViewTree: tree=" << tree_state;
  return tree_state->view_tree_token()->Clone();
}

void ViewRegistry::OnViewTreeConnectionError(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "OnViewTreeConnectionError: tree=" << tree_state;

  UnregisterViewTree(tree_state);
}

void ViewRegistry::UnregisterViewTree(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "UnregisterViewTree: tree=" << tree_state;

  // Unlink the root if needed.
  if (tree_state->root())
    UnlinkRoot(tree_state);

  // Remove from registry.
  view_trees_by_token_.erase(tree_state->view_tree_token()->value);
  delete tree_state;
}

void ViewRegistry::CreateScene(
    ViewState* view_state,
    mojo::InterfaceRequest<mojo::gfx::composition::Scene> scene) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "CreateScene: view=" << view_state;

  compositor_->CreateScene(
      scene.Pass(), view_state->label(),
      base::Bind(&ViewRegistry::OnSceneCreated, base::Unretained(this),
                 view_state->GetWeakPtr()));
}

void ViewRegistry::OnSceneCreated(
    base::WeakPtr<ViewState> view_state_weak,
    mojo::gfx::composition::SceneTokenPtr scene_token) {
  DCHECK(scene_token);
  ViewState* view_state = view_state_weak.get();
  if (view_state) {
    DVLOG(1) << "OnSceneCreated: scene_token=" << scene_token;

    view_state->set_scene_token(scene_token.Pass());
    view_state->set_scene_changed_since_last_report(true);
    InvalidateLayout(view_state);
  }
}

void ViewRegistry::RequestLayout(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DVLOG(1) << "RequestLayout: view=" << view_state;

  InvalidateLayout(view_state);
}

void ViewRegistry::AddChild(ViewState* parent_state,
                            uint32_t child_key,
                            mojo::ui::ViewTokenPtr child_view_token) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(child_view_token);
  DVLOG(1) << "AddChild: parent=" << parent_state << ", child_key=" << child_key
           << ", child=" << child_view_token;

  // Check for duplicate children.
  if (parent_state->children().find(child_key) !=
      parent_state->children().end()) {
    LOG(ERROR) << "View attempted to add a child with a duplicate key: "
               << "parent=" << parent_state << ", child_key=" << child_key
               << ", child=" << child_view_token;
    UnregisterView(parent_state);
    return;
  }

  // Check whether the desired child view still exists.
  // Adding a non-existent child still succeeds but the view manager will
  // immediately report it as being unavailable.
  ViewState* child_state = FindView(child_view_token->value);
  if (!child_state) {
    LinkChildAsUnavailable(parent_state, child_key);
    return;
  }

  // Check whether the child needs to be reparented.
  // The old parent will receive an unavailable event.  For interface symmetry,
  // we deliberately do this even if the old and new parents are the same.
  HijackView(child_state);

  // Link the child into its new parent.
  LinkChild(parent_state, child_key, child_state);
}

void ViewRegistry::RemoveChild(ViewState* parent_state, uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DVLOG(1) << "RemoveChild: parent=" << parent_state
           << ", child_key=" << child_key;

  // Check whether the child key exists in the parent.
  auto child_it = parent_state->children().find(child_key);
  if (child_it == parent_state->children().end()) {
    LOG(ERROR) << "View attempted to remove a child with an invalid key: "
               << "parent=" << parent_state << ", child_key=" << child_key;
    UnregisterView(parent_state);
    return;
  }

  // Unlink the child from its parent.
  UnlinkChild(parent_state, child_it);
}

void ViewRegistry::LayoutChild(
    ViewState* parent_state,
    uint32_t child_key,
    mojo::ui::ViewLayoutParamsPtr child_layout_params,
    const ViewLayoutCallback& callback) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(child_layout_params);
  DCHECK(child_layout_params->constraints);
  DVLOG(1) << "LayoutChild: parent=" << parent_state
           << ", child_key=" << child_key
           << ", child_layout_params=" << child_layout_params;

  // Check whether the layout parameters are well-formed.
  if (!AreViewLayoutParamsValid(child_layout_params.get())) {
    LOG(ERROR) << "View provided invalid child layout parameters: "
               << "parent=" << parent_state << ", child_key=" << child_key
               << ", child_layout_params=" << child_layout_params;
    UnregisterView(parent_state);
    callback.Run(nullptr);
    return;
  }

  // Check whether the child key exists in the parent.
  auto child_it = parent_state->children().find(child_key);
  if (child_it == parent_state->children().end()) {
    LOG(ERROR) << "View attempted to layout a child with an invalid key: "
               << "parent=" << parent_state << ", child_key=" << child_key
               << ", child_layout_params=" << child_layout_params;
    UnregisterView(parent_state);
    callback.Run(nullptr);
    return;
  }

  SetLayout(child_it->second, child_layout_params.Pass(), callback);
}

void ViewRegistry::ConnectToViewService(
    ViewState* view_state,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  associate_table_.ConnectToViewService(view_state->view_token()->Clone(),
                                        service_name, client_handle.Pass());
}

void ViewRegistry::RequestLayout(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "RequestLayout: tree=" << tree_state;

  InvalidateLayoutForRoot(tree_state);
}

void ViewRegistry::SetRoot(ViewTreeState* tree_state,
                           uint32_t root_key,
                           mojo::ui::ViewTokenPtr root_view_token) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(root_view_token);
  DVLOG(1) << "SetRoot: tree=" << tree_state << ", root_key=" << root_key
           << ", root=" << root_view_token;

  // Check whether the desired root view still exists.
  // Using a non-existent root view still succeeds but the view manager will
  // immediately report it as being unavailable.
  ViewState* root_state = FindView(root_view_token->value);
  if (root_state) {
    HijackView(root_state);
    LinkRoot(tree_state, root_state, root_key);
  } else {
    SendRootUnavailable(tree_state, root_key);
  }
  tree_state->set_explicit_root(true);
}

void ViewRegistry::ResetRoot(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DVLOG(1) << "ResetRoot: tree=" << tree_state;

  if (tree_state->root())
    UnlinkRoot(tree_state);
  tree_state->set_explicit_root(false);
}

void ViewRegistry::LayoutRoot(ViewTreeState* tree_state,
                              mojo::ui::ViewLayoutParamsPtr root_layout_params,
                              const ViewLayoutCallback& callback) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(root_layout_params);
  DCHECK(root_layout_params->constraints);
  DVLOG(1) << "LayoutRoot: tree=" << tree_state
           << ", root_layout_params=" << root_layout_params;

  // Check whether the layout parameters are well-formed.
  if (!AreViewLayoutParamsValid(root_layout_params.get())) {
    LOG(ERROR) << "View tree provided invalid root layout parameters: "
               << "tree=" << tree_state
               << ", root_layout_params=" << root_layout_params;
    UnregisterViewTree(tree_state);
    callback.Run(nullptr);
    return;
  }

  // Check whether the client called LayoutRoot without first having actually
  // set a root.
  if (!tree_state->explicit_root()) {
    LOG(ERROR) << "View tree attempted to layout the rout without having "
                  "set one first: tree="
               << tree_state << ", root_layout_params=" << root_layout_params;
    UnregisterViewTree(tree_state);
    callback.Run(nullptr);
    return;
  }

  // Check whether the root is unavailable and therefore cannot be laid out.
  // This is not an error.
  if (!tree_state->root()) {
    callback.Run(nullptr);
    return;
  }

  SetLayout(tree_state->root(), root_layout_params.Pass(), callback);
}

void ViewRegistry::ConnectToViewTreeService(
    ViewTreeState* tree_state,
    const mojo::String& service_name,
    mojo::ScopedMessagePipeHandle client_handle) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  associate_table_.ConnectToViewTreeService(
      tree_state->view_tree_token()->Clone(), service_name,
      client_handle.Pass());
}

ViewState* ViewRegistry::FindView(uint32_t view_token_value) {
  auto it = views_by_token_.find(view_token_value);
  return it != views_by_token_.end() ? it->second : nullptr;
}

void ViewRegistry::LinkChild(ViewState* parent_state,
                             uint32_t child_key,
                             ViewState* child_state) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(parent_state->children().find(child_key) ==
         parent_state->children().end());
  DCHECK(IsViewStateRegisteredDebug(child_state));

  DVLOG(2) << "Added child " << child_key << " {" << child_state->label()
           << "} to parent {" << parent_state->label() << "}";

  parent_state->children().insert({child_key, child_state});
  child_state->SetParent(parent_state, child_key);

  // Schedule layout of the parent on behalf of its newly added child.
  // We don't need to schedule layout of the child until the parent provides
  // new layout parameters.
  InvalidateLayoutForChild(parent_state, child_key);
}

void ViewRegistry::LinkChildAsUnavailable(ViewState* parent_state,
                                          uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(parent_state->children().find(child_key) ==
         parent_state->children().end());

  DVLOG(2) << "Added unavailable child " << child_key << " to parent {"
           << parent_state->label() << "}";

  parent_state->children().insert({child_key, nullptr});
  SendChildUnavailable(parent_state, child_key);

  // Don't schedule layout for the parent just yet.  Wait for it to
  // remove its child in response to the OnChildUnavailable notification.
}

void ViewRegistry::MarkChildAsUnavailable(ViewState* parent_state,
                                          uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  auto child_it = parent_state->children().find(child_key);
  DCHECK(child_it != parent_state->children().end());
  DCHECK(child_it->second);

  DVLOG(2) << "Marked unavailable child " << child_key << " {"
           << child_it->second->label() << "} from parent {"
           << parent_state->label() << "}";

  ResetStateWhenUnlinking(child_it->second);
  child_it->second->ResetContainer();
  child_it->second = nullptr;
  SendChildUnavailable(parent_state, child_key);

  // Don't schedule layout for the parent just yet.  Wait for it to
  // remove its child in response to the OnChildUnavailable notification.
  // We don't need to schedule layout for the child either since it will
  // retain its old layout parameters.
}

void ViewRegistry::UnlinkChild(ViewState* parent_state,
                               ViewState::ChildrenMap::iterator child_it) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(child_it != parent_state->children().end());

  ViewState* child_state = child_it->second;
  if (child_state) {
    DVLOG(2) << "Removed child " << child_state->key() << " {"
             << child_state->label() << "} from parent {"
             << parent_state->label() << "}";
    ResetStateWhenUnlinking(child_it->second);
    child_state->ResetContainer();
  } else {
    DVLOG(2) << "Removed unavailable child " << child_it->first
             << "} from parent {" << parent_state->label() << "}";
  }
  parent_state->children().erase(child_it);

  // Schedule layout for the parent now that it has lost its child.
  // We don't need to schedule layout for the child itself since it will
  // retain its old layout parameters.
  InvalidateLayout(parent_state);
}

ViewTreeState* ViewRegistry::FindViewTree(uint32_t view_tree_token_value) {
  auto it = view_trees_by_token_.find(view_tree_token_value);
  return it != view_trees_by_token_.end() ? it->second : nullptr;
}

void ViewRegistry::LinkRoot(ViewTreeState* tree_state,
                            ViewState* root_state,
                            uint32_t root_key) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(IsViewStateRegisteredDebug(root_state));
  DCHECK(!tree_state->root());
  DCHECK(!root_state->parent());

  DVLOG(2) << "Linked view tree root " << root_key << " {"
           << root_state->label() << "}";

  tree_state->SetRoot(root_state, root_key);

  // Schedule layout of the tree on behalf of its newly added root.
  // We don't need to schedule layout of the root until the tree provides
  // new layout parameters.
  InvalidateLayoutForRoot(tree_state);
}

void ViewRegistry::UnlinkRoot(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(tree_state->root());

  DVLOG(2) << "Unlinked view tree root " << tree_state->root()->key() << " {"
           << tree_state->root()->label() << "}";

  ResetStateWhenUnlinking(tree_state->root());
  tree_state->ResetRoot();

  // We don't need to schedule layout for the root since it will retain
  // its old layout parameters.
}

void ViewRegistry::HijackView(ViewState* view_state) {
  if (view_state->parent()) {
    MarkChildAsUnavailable(view_state->parent(), view_state->key());
  } else if (view_state->tree()) {
    ViewTreeState* tree_state = view_state->tree();
    uint32_t root_key = tree_state->root()->key();
    UnlinkRoot(tree_state);
    SendRootUnavailable(tree_state, root_key);
  }
}

void ViewRegistry::InvalidateLayout(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  // We can consider the layout request to have been satisfied if
  // there is already a pending layout request in the queue that has not
  // yet been issued (this is coalescing).  Otherwise we must manufacture
  // a new one based on the current layout parameters.
  if (view_state->layout_params() &&
      (view_state->pending_layout_requests().empty() ||
       view_state->pending_layout_requests().back()->issued())) {
    EnqueueLayoutRequest(view_state, view_state->layout_params()->Clone());
    IssueNextViewLayoutRequest(view_state);
  }
}

void ViewRegistry::InvalidateLayoutForChild(ViewState* parent_state,
                                            uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));
  DCHECK(parent_state->children().find(child_key) !=
         parent_state->children().end());

  parent_state->children_needing_layout().insert(child_key);
  InvalidateLayout(parent_state);
}

void ViewRegistry::InvalidateLayoutForRoot(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  if (!tree_state->layout_request_pending()) {
    tree_state->set_layout_request_pending(true);
    IssueNextViewTreeLayoutRequest(tree_state);
  }
}

void ViewRegistry::SetLayout(ViewState* view_state,
                             mojo::ui::ViewLayoutParamsPtr layout_params,
                             const ViewLayoutCallback& callback) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DCHECK(AreViewLayoutParamsValid(layout_params.get()));

  // Check whether the currently cached layout parameters are the same
  // and we already have a result and we have no pending layout requests.
  if (view_state->pending_layout_requests().empty() &&
      view_state->layout_params() &&
      view_state->layout_params()->Equals(*layout_params)) {
    mojo::ui::ViewLayoutInfoPtr info = view_state->CreateLayoutInfo();
    if (info) {
      DVLOG(2) << "Layout cache hit";
      view_state->set_scene_changed_since_last_report(false);
      callback.Run(info.Pass());
      return;
    }
  }

  // Check whether the layout parameters are different from the most
  // recent pending layout request if we have one.
  if (view_state->pending_layout_requests().empty() ||
      !view_state->pending_layout_requests().back()->layout_params()->Equals(
          *layout_params)) {
    // Enqueue a new request for these parameters.
    EnqueueLayoutRequest(view_state, layout_params.Pass());
  }

  // Enlist ourselves into the callbacks for the pending request.
  view_state->pending_layout_requests().back()->AddCallback(callback);
  IssueNextViewLayoutRequest(view_state);
}

void ViewRegistry::EnqueueLayoutRequest(
    ViewState* view_state,
    mojo::ui::ViewLayoutParamsPtr layout_params) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DCHECK(AreViewLayoutParamsValid(layout_params.get()));

  // Drop the previous layout request if it hasn't been issued yet.
  // This may cause callbacks to be invoked will null information.
  if (!view_state->pending_layout_requests().empty() &&
      !view_state->pending_layout_requests().back()->issued())
    view_state->pending_layout_requests().pop_back();

  // Enqueue the new request.
  view_state->pending_layout_requests().emplace_back(
      std::unique_ptr<ViewLayoutRequest>(
          new ViewLayoutRequest(layout_params.Pass())));
}

void ViewRegistry::IssueNextViewLayoutRequest(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));

  if (!view_state->pending_layout_requests().empty() &&
      !view_state->pending_layout_requests().front()->issued()) {
    view_state->pending_layout_requests().front()->set_issued(true);
    SendViewLayoutRequest(view_state);
  }
}

void ViewRegistry::IssueNextViewTreeLayoutRequest(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  if (tree_state->layout_request_pending() &&
      !tree_state->layout_request_issued()) {
    tree_state->set_layout_request_pending(false);
    tree_state->set_layout_request_issued(true);
    SendViewTreeLayoutRequest(tree_state);
  }
}

void ViewRegistry::ResetStateWhenUnlinking(ViewState* view_state) {
  // Clean up parent's recorded state for the child.
  if (view_state->parent()) {
    view_state->parent()->children_needing_layout().erase(view_state->key());
  }
}

void ViewRegistry::SendChildUnavailable(ViewState* parent_state,
                                        uint32_t child_key) {
  DCHECK(IsViewStateRegisteredDebug(parent_state));

  // TODO: Detect ANRs
  DVLOG(1) << "SendChildUnavailable: child_key=" << child_key;
  parent_state->view()->OnChildUnavailable(child_key,
                                           base::Bind(&base::DoNothing));
}

void ViewRegistry::SendRootUnavailable(ViewTreeState* tree_state,
                                       uint32_t root_key) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));

  // TODO: Detect ANRs
  DVLOG(1) << "SendRootUnavailable: root_key=" << root_key;
  tree_state->view_tree()->OnRootUnavailable(root_key,
                                             base::Bind(&base::DoNothing));
}

void ViewRegistry::SendViewLayoutRequest(ViewState* view_state) {
  DCHECK(IsViewStateRegisteredDebug(view_state));
  DCHECK(!view_state->pending_layout_requests().empty());
  DCHECK(view_state->pending_layout_requests().front()->issued());

  // TODO: Detect ANRs
  DVLOG(1) << "SendViewLayoutRequest: view.token=" << view_state->label();
  view_state->view()->OnLayout(
      view_state->pending_layout_requests().front()->layout_params()->Clone(),
      mojo::Array<uint32_t>::From(view_state->children_needing_layout()),
      base::Bind(&ViewRegistry::OnViewLayoutResult, base::Unretained(this),
                 view_state->GetWeakPtr()));
  view_state->children_needing_layout().clear();
}

void ViewRegistry::SendViewTreeLayoutRequest(ViewTreeState* tree_state) {
  DCHECK(IsViewTreeStateRegisteredDebug(tree_state));
  DCHECK(tree_state->layout_request_issued());

  // TODO: Detect ANRs
  DVLOG(1) << "SendViewTreeLayoutRequest";
  tree_state->view_tree()->OnLayout(
      base::Bind(&ViewRegistry::OnViewTreeLayoutResult, base::Unretained(this),
                 tree_state->GetWeakPtr()));
}

static bool IsSizeInBounds(mojo::ui::BoxConstraints* constraints,
                           mojo::Size* size) {
  return size && size->width >= constraints->min_width &&
         size->width <= constraints->max_width &&
         size->height >= constraints->min_height &&
         size->height <= constraints->max_height;
}

void ViewRegistry::OnViewLayoutResult(base::WeakPtr<ViewState> view_state_weak,
                                      mojo::ui::ViewLayoutResultPtr result) {
  DCHECK(result);

  ViewState* view_state = view_state_weak.get();
  if (!view_state)
    return;

  DCHECK(!view_state->pending_layout_requests().empty());
  DCHECK(view_state->pending_layout_requests().front()->issued());

  std::unique_ptr<ViewLayoutRequest> request(
      std::move(view_state->pending_layout_requests().front()));
  view_state->pending_layout_requests().erase(
      view_state->pending_layout_requests().begin());

  DVLOG(1) << "OnViewLayoutResult: view=" << view_state
           << ", params=" << request->layout_params() << ", result=" << result;

  // Validate the layout info.
  if (!IsSizeInBounds(request->layout_params()->constraints.get(),
                      result->size.get())) {
    LOG(ERROR) << "View returned invalid size in its layout info: "
               << "view=" << view_state
               << ", params=" << request->layout_params()
               << ", result=" << result;
    UnregisterView(view_state);
    return;
  }

  // Assume the parent or root will not see the new layout information if
  // there are no callbacks so we need to inform it when things change.
  const bool size_changed =
      !view_state->layout_result() ||
      !view_state->layout_result()->size->Equals(*result->size);
  const bool recurse =
      !request->has_callbacks() &&
      (size_changed || view_state->scene_changed_since_last_report());

  view_state->set_layout_params(request->TakeLayoutParams().Pass());
  view_state->set_layout_result(result.Pass());

  mojo::ui::ViewLayoutInfoPtr info = view_state->CreateLayoutInfo();
  if (info) {
    view_state->set_scene_changed_since_last_report(false);
    request->DispatchLayoutInfo(info.Pass());
  }

  if (recurse) {
    if (view_state->parent()) {
      InvalidateLayoutForChild(view_state->parent(), view_state->key());
    } else if (view_state->tree()) {
      InvalidateLayoutForRoot(view_state->tree());
    }
  }

  IssueNextViewLayoutRequest(view_state);
}

void ViewRegistry::OnViewTreeLayoutResult(
    base::WeakPtr<ViewTreeState> tree_state_weak) {
  ViewTreeState* tree_state = tree_state_weak.get();
  if (tree_state) {
    DCHECK(tree_state->layout_request_issued());

    DVLOG(1) << "OnViewTreeLayoutResult";

    tree_state->set_layout_request_issued(false);
    IssueNextViewTreeLayoutRequest(tree_state);
  }
}

}  // namespace view_manager
