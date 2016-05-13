// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "base/macros.h"
#include "base/memory/scoped_ptr.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/application/content_handler_factory.h"
#include "mojo/public/c/system/main.h"
#include "mojo/public/cpp/application/application_delegate.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/application/service_provider_impl.h"
#include "mojo/services/content_handler/interfaces/content_handler.mojom.h"

namespace mojo {
namespace examples {

class RecursiveContentHandler : public ApplicationDelegate,
                                public ContentHandlerFactory::ManagedDelegate {
 public:
  RecursiveContentHandler() : content_handler_factory_(this) {}

 private:
  // Overridden from ApplicationDelegate:
  bool ConfigureIncomingConnection(
      ServiceProviderImpl* service_provider_impl) override {
    service_provider_impl->AddService<ContentHandler>(
        content_handler_factory_.GetInterfaceRequestHandler());
    return true;
  }

  // Overridden from ContentHandlerFactory::ManagedDelegate:
  scoped_ptr<ContentHandlerFactory::HandledApplicationHolder>
  CreateApplication(InterfaceRequest<Application> application_request,
                    URLResponsePtr response) override {
    LOG(INFO) << "RecursiveContentHandler called with url: " << response->url;
    return make_handled_factory_holder(new mojo::ApplicationImpl(
        new RecursiveContentHandler(), application_request.Pass()));
  }

  ContentHandlerFactory content_handler_factory_;

  DISALLOW_COPY_AND_ASSIGN(RecursiveContentHandler);
};

}  // namespace examples
}  // namespace mojo

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(
      new mojo::examples::RecursiveContentHandler());
  return runner.Run(application_request);
}
