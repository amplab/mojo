// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:mojo/bindings.dart' as bindings;
import 'package:mojo/core.dart' as core;
import 'package:_mojo_for_test_only/expect.dart';
import 'package:_mojo_for_test_only/sample/sample_interfaces.mojom.dart' as sample;

// Bump this if sample_interfaces.mojom adds higher versions.
const int maxVersion = 3;

// Implementation of IntegerAccessor.
class IntegerAccessorImpl implements sample.IntegerAccessor {
  // Some initial value.
  int _value = 0;

  dynamic getInteger([Function responseFactory = null]) =>
      responseFactory(_value, sample.Enum.value);

  void setInteger(int data, sample.Enum type) {
    Expect.equals(sample.Enum.value, type);
    // Update data.
    _value = data;
  }
}

// Returns [proxy, stub].
List buildConnectedProxyAndStub() {
  var pipe = new core.MojoMessagePipe();
  var proxy = new sample.IntegerAccessorProxy.fromEndpoint(pipe.endpoints[0]);
  var impl = new IntegerAccessorImpl();
  var stub =
      new sample.IntegerAccessorStub.fromEndpoint(pipe.endpoints[1], impl);
  return [proxy, stub];
}

void closeProxyAndStub(List ps) {
  var proxy = ps[0];
  var stub = ps[1];
  proxy.close();
  stub.close();
}

testQueryVersion() async {
  var ps = buildConnectedProxyAndStub();
  var proxy = ps[0];
  // The version starts at 0.
  Expect.equals(0, proxy.ctrl.version);
  // We are talking to an implementation that supports version maxVersion.
  var providedVersion = await proxy.ctrl.queryVersion();
  Expect.equals(maxVersion, providedVersion);
  // The proxy's version has been updated.
  Expect.equals(providedVersion, proxy.ctrl.version);
  closeProxyAndStub(ps);
}

testRequireVersionSuccess() async {
  var ps = buildConnectedProxyAndStub();
  var proxy = ps[0];
  Expect.equals(0, proxy.ctrl.version);
  // Require version maxVersion.
  proxy.ctrl.requireVersion(maxVersion);
  // Make a request and get a response.
  var response = await proxy.getInteger();
  Expect.equals(0, response.data);
  closeProxyAndStub(ps);
}

testRequireVersionDisconnect() async {
  var ps = buildConnectedProxyAndStub();
  var proxy = ps[0];
  Expect.equals(0, proxy.ctrl.version);
  // Require version maxVersion.
  proxy.ctrl.requireVersion(maxVersion);
  Expect.equals(maxVersion, proxy.ctrl.version);
  // Set integer.
  proxy.setInteger(34, sample.Enum.value);
  // Get integer.
  var response = await proxy.getInteger();
  Expect.equals(34, response.data);
  // Require version maxVersion + 1
  proxy.ctrl.requireVersion(maxVersion + 1);
  // Version number is updated synchronously.
  Expect.equals(maxVersion + 1, proxy.ctrl.version);
  // Get integer, expect a failure.
  bool exceptionCaught = false;
  try {
    response = await proxy.getInteger();
    Expect.fail('Should have an exception.');
  } catch(e) {
    exceptionCaught = true;
  }
  Expect.isTrue(exceptionCaught);
  closeProxyAndStub(ps);
}

main() async {
  await testQueryVersion();
  await testRequireVersionSuccess();
  await testRequireVersionDisconnect();
}
