// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <unistd.h>

#include <string>

#include "base/bind.h"
#include "base/macros.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/ui/choreographer.h"
#include "mojo/ui/ganesh_view.h"
#include "mojo/ui/input_handler.h"
#include "mojo/ui/view_provider_app.h"
#include "third_party/dejavu-fonts-ttf-2.34/kDejaVuSansMonoRegular.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkColor.h"
#include "third_party/skia/include/core/SkRect.h"
#include "third_party/skia/include/core/SkStream.h"
#include "third_party/skia/include/core/SkTypeface.h"

namespace examples {

namespace {
constexpr uint32_t kContentImageResourceId = 1;
constexpr uint32_t kRootNodeId = mojo::gfx::composition::kSceneRootNodeId;

enum class Action {
  kHang10,
  kStutter30,
  kCrash,
};

struct Button {
  const char* label;
  Action action;
};

const Button kButtons[] = {
    {"Hang for 10 seconds", Action::kHang10},
    {"Stutter for 30 seconds", Action::kStutter30},
    {"Crash!", Action::kCrash},
};

constexpr SkScalar kButtonWidth = 300;
constexpr SkScalar kButtonHeight = 30;
constexpr SkScalar kMargin = 15;
}  // namespace

class JankView : public mojo::ui::GaneshView,
                 public mojo::ui::ChoreographerDelegate,
                 public mojo::ui::InputListener {
 public:
  JankView(mojo::ApplicationImpl* app_impl,
           mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request)
      : GaneshView(app_impl, view_owner_request.Pass(), "Jank"),
        choreographer_(scene(), this),
        input_handler_(GetViewServiceProvider(), this),
        typeface_(skia::AdoptRef(SkTypeface::CreateFromStream(
            new SkMemoryStream(font_data::kDejaVuSansMonoRegular.data,
                               font_data::kDejaVuSansMonoRegular.size)))) {}

  ~JankView() override {}

 private:
  // |GaneshView|:
  void OnPropertiesChanged(
      uint32_t old_scene_version,
      mojo::ui::ViewPropertiesPtr old_properties) override {
    choreographer_.ScheduleDraw();
  }

  // |InputListener|:
  void OnEvent(mojo::EventPtr event, const OnEventCallback& callback) override {
    if (event->pointer_data && event->action == mojo::EventType::POINTER_DOWN) {
      SkScalar x = event->pointer_data->x;
      SkScalar y = event->pointer_data->y;
      if (x >= kMargin && x <= kButtonWidth + kMargin) {
        int index = (y - kMargin) / (kButtonHeight + kMargin);
        if (index >= 0 &&
            size_t(index) < sizeof(kButtons) / sizeof(kButtons[0]) &&
            y < (kButtonHeight + kMargin) * (index + 1))
          OnClick(kButtons[index]);
      }
    }
    callback.Run(false);
  }

  // |ChoreographerDelegate|:
  void OnDraw(const mojo::gfx::composition::FrameInfo& frame_info,
              const base::TimeDelta& time_delta) override {
    if (!properties())
      return;

    auto update = mojo::gfx::composition::SceneUpdate::New();

    const mojo::Size& size = *properties()->view_layout->size;
    if (size.width > 0 && size.height > 0) {
      mojo::RectF bounds;
      bounds.width = size.width;
      bounds.height = size.height;

      mojo::gfx::composition::ResourcePtr content_resource =
          ganesh_renderer()->DrawCanvas(
              size,
              base::Bind(&JankView::DrawContent, base::Unretained(this), size));
      DCHECK(content_resource);
      update->resources.insert(kContentImageResourceId,
                               content_resource.Pass());

      auto root_node = mojo::gfx::composition::Node::New();
      root_node->hit_test_behavior =
          mojo::gfx::composition::HitTestBehavior::New();
      root_node->op = mojo::gfx::composition::NodeOp::New();
      root_node->op->set_image(mojo::gfx::composition::ImageNodeOp::New());
      root_node->op->get_image()->content_rect = bounds.Clone();
      root_node->op->get_image()->image_resource_id = kContentImageResourceId;
      update->nodes.insert(kRootNodeId, root_node.Pass());
    } else {
      auto root_node = mojo::gfx::composition::Node::New();
      update->nodes.insert(kRootNodeId, root_node.Pass());
    }

    scene()->Update(update.Pass());

    auto metadata = mojo::gfx::composition::SceneMetadata::New();
    metadata->version = scene_version();
    scene()->Publish(metadata.Pass());

    choreographer_.ScheduleDraw();

    if (MojoGetTimeTicksNow() < stutter_end_time_)
      sleep(2);
  }

  void DrawContent(const mojo::Size& size, SkCanvas* canvas) {
    SkScalar hsv[3] = {fmod(MojoGetTimeTicksNow() * 0.000001f * 60, 360.f), 1,
                       1};
    canvas->clear(SkHSVToColor(hsv));

    SkScalar x = kMargin;
    SkScalar y = kMargin;
    for (const auto& button : kButtons) {
      DrawButton(canvas, button.label,
                 SkRect::MakeXYWH(x, y, kButtonWidth, kButtonHeight));
      y += kButtonHeight + kMargin;
    }
  }

  void DrawButton(SkCanvas* canvas, const char* label, const SkRect& bounds) {
    SkPaint boxPaint;
    boxPaint.setColor(SkColorSetRGB(200, 200, 200));
    canvas->drawRect(bounds, boxPaint);
    boxPaint.setColor(SkColorSetRGB(40, 40, 40));
    boxPaint.setStyle(SkPaint::kStroke_Style);
    canvas->drawRect(bounds, boxPaint);

    SkPaint textPaint;
    textPaint.setColor(SK_ColorBLACK);
    textPaint.setTextSize(16);
    textPaint.setTextEncoding(SkPaint::kUTF8_TextEncoding);
    textPaint.setTypeface(typeface_.get());
    textPaint.setAntiAlias(true);
    SkRect textBounds;
    textPaint.measureText(label, strlen(label), &textBounds);
    canvas->drawText(label, strlen(label),
                     bounds.centerX() - textBounds.centerX(),
                     bounds.centerY() - textBounds.centerY(), textPaint);
  }

  void OnClick(const Button& button) {
    LOG(INFO) << "Clicked: " << button.label;

    switch (button.action) {
      case Action::kHang10: {
        sleep(10);
        break;
      }

      case Action::kStutter30: {
        stutter_end_time_ = MojoGetTimeTicksNow() + 30 * 1000000;
        break;
      }

      case Action::kCrash: {
        abort();
        break;
      }
    }
  }

  mojo::ui::Choreographer choreographer_;
  mojo::ui::InputHandler input_handler_;
  skia::RefPtr<SkTypeface> typeface_;
  int64_t stutter_end_time_ = 0u;

  DISALLOW_COPY_AND_ASSIGN(JankView);
};

class JankApp : public mojo::ui::ViewProviderApp {
 public:
  JankApp() {}
  ~JankApp() override {}

  void CreateView(
      const std::string& connection_url,
      mojo::InterfaceRequest<mojo::ui::ViewOwner> view_owner_request,
      mojo::InterfaceRequest<mojo::ServiceProvider> services,
      mojo::InterfaceHandle<mojo::ServiceProvider> exposed_services) override {
    new JankView(app_impl(), view_owner_request.Pass());
  }

 private:
  DISALLOW_COPY_AND_ASSIGN(JankApp);
};

}  // namespace examples

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new examples::JankApp());
  return runner.Run(application_request);
}
