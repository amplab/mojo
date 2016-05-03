// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef MOJO_EDK_SYSTEM_HANDLE_TRANSPORT_H_
#define MOJO_EDK_SYSTEM_HANDLE_TRANSPORT_H_

#include "mojo/edk/system/dispatcher.h"
#include "mojo/edk/util/ref_ptr.h"
#include "mojo/edk/util/thread_annotations.h"

namespace mojo {
namespace system {

class MessagePipe;

// Wrapper around a |Dispatcher| pointer, while it's being processed to be
// passed in a message pipe. See the comment about
// |Dispatcher::HandleTableAccess| for more details.
//
// Note: This class is deliberately "thin" -- no more expensive than a
// |Dispatcher*|.
//
// TODO(vtl): Add handle rights to this, and rename it to HandleTransport.
class DispatcherTransport final {
 public:
  DispatcherTransport() : dispatcher_(nullptr) {}

  void End() MOJO_NOT_THREAD_SAFE;

  Dispatcher::Type GetType() const { return dispatcher_->GetType(); }
  bool IsBusy() const MOJO_NOT_THREAD_SAFE {
    return dispatcher_->IsBusyNoLock();
  }
  void Close() MOJO_NOT_THREAD_SAFE { dispatcher_->CloseNoLock(); }
  util::RefPtr<Dispatcher> CreateEquivalentDispatcherAndClose(
      MessagePipe* message_pipe,
      unsigned port) MOJO_NOT_THREAD_SAFE {
    return dispatcher_->CreateEquivalentDispatcherAndCloseNoLock(message_pipe,
                                                                 port);
  }

  bool is_valid() const { return !!dispatcher_; }

 private:
  friend class Dispatcher::HandleTableAccess;

  explicit DispatcherTransport(Dispatcher* dispatcher)
      : dispatcher_(dispatcher) {}

  Dispatcher* dispatcher_;

  // Copy and assign allowed.
};

}  // namespace system
}  // namespace mojo

#endif  // MOJO_EDK_SYSTEM_HANDLE_TRANSPORT_H_
