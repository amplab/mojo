// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include <memory>

#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/application_runner.h"
#include "mojo/public/cpp/bindings/callback.h"
#include "mojo/public/cpp/bindings/interface_request.h"
#include "mojo/public/cpp/bindings/strong_binding.h"
#include "shell/test/pingable.mojom.h"

using mojo::String;

class PingableImpl : public Pingable {
 public:
  PingableImpl(mojo::InterfaceRequest<Pingable> request,
               const std::string& app_url,
               const std::string& connection_url)
      : binding_(this, request.Pass()),
        app_url_(app_url),
        connection_url_(connection_url) {}

  ~PingableImpl() override {}

 private:
  void Ping(
      const String& message,
      const mojo::Callback<void(String, String, String)>& callback) override {
    callback.Run(app_url_, connection_url_, message);
  }

  mojo::StrongBinding<Pingable> binding_;
  std::string app_url_;
  std::string connection_url_;
};

class PingableApp : public mojo::ApplicationDelegate {
 public:
  PingableApp() {}
  ~PingableApp() override {}

 private:
  // ApplicationDelegate:
  void Initialize(mojo::ApplicationImpl* impl) override {
    app_url_ = impl->url();
  }

  bool ConfigureIncomingConnection(
      mojo::ServiceProviderImpl* service_provider_impl) override {
    service_provider_impl->AddService<Pingable>(
        [this](const mojo::ConnectionContext& connection_context,
               mojo::InterfaceRequest<Pingable> pingable_request) {
          new PingableImpl(pingable_request.Pass(), app_url_,
                           connection_context.connection_url);
        });
    return true;
  }

  std::string app_url_;
};

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunner runner(
      std::unique_ptr<PingableApp>(new PingableApp()));
  return runner.Run(application_request);
}
