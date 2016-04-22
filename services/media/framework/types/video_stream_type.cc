// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/logging.h"
#include "services/media/framework/types/video_stream_type.h"
#include "services/media/framework/util/safe_clone.h"

namespace mojo {
namespace media {

VideoStreamType::VideoStreamType(const std::string& encoding,
                                 std::unique_ptr<Bytes> encoding_parameters,
                                 VideoProfile profile,
                                 PixelFormat pixel_format,
                                 ColorSpace color_space,
                                 uint32_t width,
                                 uint32_t height,
                                 uint32_t coded_width,
                                 uint32_t coded_height)
    : StreamType(StreamType::Medium::kVideo,
                 encoding,
                 std::move(encoding_parameters)),
      profile_(profile),
      pixel_format_(pixel_format),
      color_space_(color_space),
      width_(width),
      height_(height),
      coded_width_(coded_width),
      coded_height_(coded_height) {}

VideoStreamType::~VideoStreamType() {}

const VideoStreamType* VideoStreamType::video() const {
  return this;
}

std::unique_ptr<StreamType> VideoStreamType::Clone() const {
  return Create(encoding(), SafeClone(encoding_parameters()), profile(),
                pixel_format(), color_space(), width(), height(), coded_width(),
                coded_height());
}

VideoStreamTypeSet::VideoStreamTypeSet(
    const std::vector<std::string>& encodings,
    Range<uint32_t> width,
    Range<uint32_t> height)
    : StreamTypeSet(StreamType::Medium::kVideo, encodings),
      width_(width),
      height_(height) {}

VideoStreamTypeSet::~VideoStreamTypeSet() {}

const VideoStreamTypeSet* VideoStreamTypeSet::video() const {
  return this;
}

std::unique_ptr<StreamTypeSet> VideoStreamTypeSet::Clone() const {
  return Create(encodings(), width(), height());
}

}  // namespace media
}  // namespace mojo
