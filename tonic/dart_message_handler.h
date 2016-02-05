// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef TONIC_DART_MESSAGE_HANDLER_H_
#define TONIC_DART_MESSAGE_HANDLER_H_

#include "base/callback.h"
#include "base/message_loop/message_loop.h"
#include "dart/runtime/include/dart_api.h"

namespace tonic {
class DartState;

class DartMessageHandler {
 public:
  DartMessageHandler();
  virtual ~DartMessageHandler();

  // Messages for the current isolate will be scheduled on |runner|.
  void Initialize(const scoped_refptr<base::SingleThreadTaskRunner>& runner);

 protected:
  // Called from an unknown thread for each message.
  virtual void OnMessage(DartState* dart_state);
  // By default, called on the task runner's thread for each message.
  virtual void OnHandleMessage(DartState* dart_state);

  scoped_refptr<base::SingleThreadTaskRunner> task_runner() const {
    return task_runner_;
  }

  bool handled_first_message() const {
    return handled_first_message_;
  }

  void set_handled_first_message(bool handled_first_message) {
    handled_first_message_ = handled_first_message;
  }

  bool handled_first_message_;
  scoped_refptr<base::SingleThreadTaskRunner> task_runner_;

 private:
  static void HandleMessage(base::WeakPtr<DartState> dart_state);
  static void MessageNotifyCallback(Dart_Isolate dest_isolate);
};

}  // namespace tonic

#endif  // TONIC_DART_MESSAGE_HANDLER_H_