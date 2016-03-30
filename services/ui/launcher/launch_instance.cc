// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/ui/launcher/launch_instance.h"

#include "base/command_line.h"
#include "base/logging.h"
#include "base/trace_event/trace_event.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_connection.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/services/ui/views/interfaces/view_provider.mojom.h"
#include "services/ui/launcher/launcher_view_tree.h"

namespace launcher {

LaunchInstance::LaunchInstance(mojo::ApplicationImpl* app_impl,
                               const std::string& app_url,
                               const base::Closure& shutdown_callback)
    : app_impl_(app_impl),
      app_url_(app_url),
      shutdown_callback_(shutdown_callback),
      viewport_event_dispatcher_binding_(this) {}

LaunchInstance::~LaunchInstance() {}

void LaunchInstance::Launch() {
  DVLOG(1) << "Launching " << app_url_;
  TRACE_EVENT0("launcher", __func__);

  app_impl_->ConnectToService("mojo:compositor_service", &compositor_);
  compositor_.set_connection_error_handler(base::Bind(
      &LaunchInstance::OnCompositorConnectionError, base::Unretained(this)));

  app_impl_->ConnectToService("mojo:view_manager_service", &view_manager_);
  view_manager_.set_connection_error_handler(base::Bind(
      &LaunchInstance::OnViewManagerConnectionError, base::Unretained(this)));

  InitViewport();

  mojo::ui::ViewProviderPtr client_view_provider;
  app_impl_->ConnectToService(app_url_, &client_view_provider);

  client_view_provider->CreateView(mojo::GetProxy(&client_view_owner_), nullptr,
                                   nullptr);
}

void LaunchInstance::OnCompositorConnectionError() {
  LOG(ERROR) << "Exiting due to compositor connection error.";
  shutdown_callback_.Run();
}

void LaunchInstance::OnViewManagerConnectionError() {
  LOG(ERROR) << "Exiting due to view manager connection error.";
  shutdown_callback_.Run();
}

void LaunchInstance::InitViewport() {
  app_impl_->ConnectToService("mojo:native_viewport_service", &viewport_);
  viewport_.set_connection_error_handler(base::Bind(
      &LaunchInstance::OnViewportConnectionError, base::Unretained(this)));

  mojo::NativeViewportEventDispatcherPtr dispatcher;
  viewport_event_dispatcher_binding_.Bind(GetProxy(&dispatcher));
  viewport_->SetEventDispatcher(dispatcher.Pass());

  // Match the Nexus 5 aspect ratio initially.
  auto size = mojo::Size::New();
  size->width = 320;
  size->height = 640;

  auto requested_configuration = mojo::SurfaceConfiguration::New();
  viewport_->Create(
      size.Clone(), requested_configuration.Pass(),
      base::Bind(&LaunchInstance::OnViewportCreated, base::Unretained(this)));
}

void LaunchInstance::OnViewportConnectionError() {
  LOG(ERROR) << "Exiting due to viewport connection error.";
  shutdown_callback_.Run();
}

void LaunchInstance::OnViewportCreated(mojo::ViewportMetricsPtr metrics) {
  viewport_->Show();

  mojo::ContextProviderPtr context_provider;
  viewport_->GetContextProvider(GetProxy(&context_provider));

  view_tree_.reset(new LauncherViewTree(compositor_.get(), view_manager_.get(),
                                        context_provider.Pass(), metrics.Pass(),
                                        shutdown_callback_));
  view_tree_->SetRoot(client_view_owner_.Pass());

  RequestUpdatedViewportMetrics();
}

void LaunchInstance::OnViewportMetricsChanged(
    mojo::ViewportMetricsPtr metrics) {
  if (view_tree_) {
    view_tree_->SetViewportMetrics(metrics.Pass());
    RequestUpdatedViewportMetrics();
  }
}

void LaunchInstance::RequestUpdatedViewportMetrics() {
  viewport_->RequestMetrics(base::Bind(
      &LaunchInstance::OnViewportMetricsChanged, base::Unretained(this)));
}

void LaunchInstance::OnEvent(mojo::EventPtr event,
                             const mojo::Callback<void()>& callback) {
  if (view_tree_)
    view_tree_->DispatchEvent(event.Pass());
  callback.Run();
}

}  // namespace launcher
