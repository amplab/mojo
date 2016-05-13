// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/test_service/test_service_application.h"

#include <assert.h>

#include <memory>

#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/utility/run_loop.h"
#include "services/test_service/test_service_impl.h"
#include "services/test_service/test_time_service_impl.h"

namespace mojo {
namespace test {

TestServiceApplication::TestServiceApplication()
    : ref_count_(0), app_impl_(nullptr) {}

TestServiceApplication::~TestServiceApplication() {}

void TestServiceApplication::Initialize(ApplicationImpl* app) {
  app_impl_ = app;
}

bool TestServiceApplication::ConfigureIncomingConnection(
    ApplicationConnection* connection) {
  connection->GetServiceProviderImpl().AddService<TestService>(
      [this](const ConnectionContext& connection_context,
             InterfaceRequest<TestService> request) {
        new TestServiceImpl(app_impl_, this, request.Pass());
        AddRef();
      });
  connection->GetServiceProviderImpl().AddService<TestTimeService>(
      [this](const ConnectionContext& connection_context,
             InterfaceRequest<TestTimeService> request) {
        new TestTimeServiceImpl(app_impl_, request.Pass());
      });
  return true;
}

void TestServiceApplication::AddRef() {
  assert(ref_count_ >= 0);
  ref_count_++;
}

void TestServiceApplication::ReleaseRef() {
  assert(ref_count_ > 0);
  ref_count_--;
  if (ref_count_ <= 0)
    RunLoop::current()->Quit();
}

}  // namespace test
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<mojo::test::TestServiceApplication>(
          new mojo::test::TestServiceApplication()));
  return runner.Run(application_request);
}
