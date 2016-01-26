// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_SERVICES_GFX_COMPOSITION_CPP_FORMATTING_H_
#define MOJO_SERVICES_GFX_COMPOSITION_CPP_FORMATTING_H_

#include "mojo/public/cpp/bindings/formatting.h"
#include "mojo/services/geometry/cpp/formatting.h"
#include "mojo/services/gfx/composition/interfaces/compositor.mojom.h"
#include "mojo/services/gfx/composition/interfaces/scheduling.mojom.h"

namespace mojo {
namespace gfx {
namespace composition {

std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::SceneToken& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::SceneUpdate& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::SceneMetadata& value);

std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::Resource& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::SceneResource& value);
std::ostream& operator<<(
    std::ostream& os,
    const mojo::gfx::composition::MailboxTextureResource& value);

std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::Node& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::NodeOp& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::RectNodeOp& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::ImageNodeOp& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::SceneNodeOp& value);
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::LayerNodeOp& value);

// FIXME(jeffbrown): Passing as a pointer to disambiguate with the operator<<
// generated by mojom itself for this enum, which unfortunately doesn't print
// names.  We should improve mojom then get rid of this overload.
std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::Node::Combinator* value);

std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::Color& value);

std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::Blend& value);

std::ostream& operator<<(std::ostream& os,
                         const mojo::gfx::composition::FrameInfo& value);

}  // namespace composition
}  // namespace gfx
}  // namespace mojo

#endif  // MOJO_SERVICES_GFX_COMPOSITION_CPP_FORMATTING_H_
