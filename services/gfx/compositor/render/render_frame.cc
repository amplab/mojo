// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/gfx/compositor/render/render_frame.h"

#include "base/logging.h"
#include "skia/ext/refptr.h"
#include "third_party/skia/include/core/SkCanvas.h"
#include "third_party/skia/include/core/SkPicture.h"

namespace compositor {

RenderFrame::RenderFrame(const skia::RefPtr<SkPicture>& picture,
                         const SkIRect& viewport,
                         const mojo::gfx::composition::FrameInfo& frame_info)
    : picture_(picture), viewport_(viewport), frame_info_(frame_info) {
  DCHECK(picture_);
}

RenderFrame::~RenderFrame() {}

void RenderFrame::Paint(SkCanvas* canvas) const {
  DCHECK(canvas);

  // TODO: Consider using GrDrawContext instead of SkCanvas.
  canvas->clear(SK_ColorBLACK);
  canvas->drawPicture(picture_.get());
}

}  // namespace compositor
