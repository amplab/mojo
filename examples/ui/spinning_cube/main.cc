// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "examples/ui/spinning_cube/spinning_cube_app.h"
#include "mojo/application/application_runner_chromium.h"
#include "mojo/public/c/system/main.h"

MojoResult MojoMain(MojoHandle application_request) {
  mojo::ApplicationRunnerChromium runner(new examples::SpinningCubeApp);
  return runner.Run(application_request);
}
