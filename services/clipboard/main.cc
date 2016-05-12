// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/interface_factory.h"
#include "services/clipboard/clipboard_standalone_impl.h"

class Delegate : public mojo::ApplicationDelegate,
                 public mojo::InterfaceFactory<mojo::Clipboard> {
 public:
  Delegate() {}
  ~Delegate() override {}

  // mojo::ApplicationDelegate implementation.
  bool ConfigureIncomingConnection(
      mojo::ApplicationConnection* connection) override {
    connection->AddService(this);
    return true;
  }

  // mojo::InterfaceFactory<mojo::Clipboard> implementation.
  void Create(const mojo::ConnectionContext& connection_context,
              mojo::InterfaceRequest<mojo::Clipboard> request) override {
    // TODO(erg): Write native implementations of the clipboard. For now, we
    // just build a clipboard which doesn't interact with the system.
    new clipboard::ClipboardStandaloneImpl(request.Pass());
  }
};

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new Delegate);
  return runner.Run(application_request);
}
