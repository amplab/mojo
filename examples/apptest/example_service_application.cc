// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/apptest/example_service_application.h"

#include <memory>

#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_runner.h"

namespace mojo {

ExampleServiceApplication::ExampleServiceApplication() {}

ExampleServiceApplication::~ExampleServiceApplication() {}

bool ExampleServiceApplication::ConfigureIncomingConnection(
    ApplicationConnection* connection) {
  connection->AddService<ExampleService>(this);
  return true;
}

void ExampleServiceApplication::Create(
    const ConnectionContext& connection_context,
    InterfaceRequest<ExampleService> request) {
  // Not leaked: ExampleServiceImpl is strongly bound to the pipe.
  new ExampleServiceImpl(request.Pass());
}

}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<mojo::ExampleServiceApplication>(
          new mojo::ExampleServiceApplication()));
  return runner.Run(application_request);
}
