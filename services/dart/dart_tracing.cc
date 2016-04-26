// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "services/dart/dart_tracing.h"

#include <utility>

#include "dart/runtime/include/dart_tools_api.h"
#include "mojo/public/cpp/application/application_impl.h"
#include "mojo/public/cpp/bindings/interface_handle.h"
#include "mojo/public/cpp/bindings/interface_request.h"
#include "mojo/public/interfaces/application/service_provider.mojom.h"

namespace dart {

void DartTimelineController::Enable(const mojo::String& categories) {
  if (categories == mojo::String("Dart")) {
    Dart_GlobalTimelineSetRecordedStreams(DART_TIMELINE_STREAM_DART);
  } else {
    // TODO(johnmccutchan): Respect |categories|.
    EnableAll();
  }
}

void DartTimelineController::EnableAll() {
  Dart_GlobalTimelineSetRecordedStreams(DART_TIMELINE_STREAM_ALL |
                                        DART_TIMELINE_STREAM_VM);
}

void DartTimelineController::Disable() {
  Dart_GlobalTimelineSetRecordedStreams(DART_TIMELINE_STREAM_DISABLE);
}

DartTraceProvider::DartTraceProvider()
    : binding_(this) {
}

DartTraceProvider::~DartTraceProvider() {
}

void DartTraceProvider::Bind(
    mojo::InterfaceRequest<tracing::TraceProvider> request) {
  if (!binding_.is_bound()) {
    binding_.Bind(request.Pass());
  } else {
    LOG(ERROR) << "Cannot accept two connections to TraceProvider.";
  }
}

// tracing::TraceProvider implementation:
void DartTraceProvider::StartTracing(
    const mojo::String& categories,
    mojo::InterfaceHandle<tracing::TraceRecorder> recorder) {
  DCHECK(!recorder_.get());
  recorder_ = tracing::TraceRecorderPtr::Create(std::move(recorder));
  DartTimelineController::Enable(categories);
}

static void AppendStreamConsumer(Dart_StreamConsumer_State state,
                                 const char* stream_name,
                                 const uint8_t* buffer,
                                 intptr_t buffer_length,
                                 void* user_data) {
  if (state == Dart_StreamConsumer_kFinish) {
    return;
  }
  std::vector<uint8_t>* data =
      reinterpret_cast<std::vector<uint8_t>*>(user_data);
  DCHECK(data);
  if (state == Dart_StreamConsumer_kStart) {
    data->clear();
    return;
  }
  DCHECK_EQ(state, Dart_StreamConsumer_kData);
  // Append data.
  data->insert(data->end(), buffer, buffer + buffer_length);
}

// recorder_->Record():
// 1. Doesn't like big hunks of data.
//    See: https://github.com/domokit/mojo/issues/564
// 2. Expects to receive one or more complete JSON maps per call.
// Therefore, we do a little parsing of data to split it up and send it
// over to the trace recorder.
void DartTraceProvider::SplitAndRecord(char* data, size_t length) {
  const size_t kInvalidIndex = length;
  const size_t kMinChunkLength = 1024 * 1024;  // 1MB.
  size_t start = kInvalidIndex;
  size_t end = 0;
  int curly_braces = 0;
  for (size_t i = 0; i < length; i++) {
    if (data[i] == '{') {
      if ((curly_braces == 0) && (start == kInvalidIndex)) {
        start = i;
      }
      curly_braces++;
    }
    if (data[i] == '}') {
      DCHECK(curly_braces > 0);
      curly_braces--;
      if (curly_braces == 0) {
        end = i;
      }
    }
    if ((curly_braces == 0) && (start != kInvalidIndex) &&
        (((end - start) >= kMinChunkLength) || (i == (length - 1)))) {
      char* json_start = data + start;
      char* json_end = data + end + 1;
      mojo::String json(json_start, json_end - json_start);
      recorder_->Record(json);
      start = kInvalidIndex;
    }
  }
}

// tracing::TraceProvider implementation:
void DartTraceProvider::StopTracing() {
  DCHECK(recorder_);
  DartTimelineController::Disable();
  std::vector<uint8_t> data;
  bool got_trace = Dart_GlobalTimelineGetTrace(AppendStreamConsumer, &data);
  if (got_trace) {
    SplitAndRecord(reinterpret_cast<char*>(data.data()), data.size());
  }
  recorder_.reset();
}

DartTracingImpl::DartTracingImpl() {
}

DartTracingImpl::~DartTracingImpl() {
}

void DartTracingImpl::Initialize(mojo::ApplicationImpl* app) {
  mojo::InterfaceHandle<mojo::ServiceProvider> outgoing_sp_handle;
  mojo::InterfaceRequest<mojo::ServiceProvider> outgoing_sp_request =
      GetProxy(&outgoing_sp_handle);
  app->shell()->ConnectToApplication("mojo:tracing", nullptr,
                                     outgoing_sp_handle.Pass());
  outgoing_sp_for_tracing_service_.Bind(outgoing_sp_request.Pass());
  outgoing_sp_for_tracing_service_.AddService(this);
}

void DartTracingImpl::Create(
    mojo::ApplicationConnection* connection,
    mojo::InterfaceRequest<tracing::TraceProvider> request) {
  provider_impl_.Bind(request.Pass());
}

}  // namespace dart
