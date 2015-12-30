// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library mojo_builtin;

import 'dart:async';
import 'dart:convert';
import 'dart:mojo.internal';

const _logBuiltin = false;

// import 'root_library'; happens here from C Code
// The root library (aka the script) is imported into this library. The
// embedder uses this to lookup the main entrypoint in the root library's
// namespace.
Function _getMainClosure() => main;

// Corelib 'print' implementation.
void _print(arg) {
  _Logger._printString(arg.toString());
}

class _Logger {
  static void _printString(String s) native "Logger_PrintString";
}

_getPrintClosure() => _print;

Uri _uriBase() {
  return _entryPointScript.resolve('.');
}

_getUriBaseClosure() => _uriBase;

_setupHooks() {
  VMLibraryHooks.eventHandlerSendData = MojoHandleWatcher.timer;
  VMLibraryHooks.timerMillisecondClock = MojoCoreNatives.timerMillisecondClock;
}

String _rawCwd;
Uri _cachedWorkingDirectory;
Uri get _workingDirectory {
  if (_cachedWorkingDirectory != null) {
    return _cachedWorkingDirectory;
  }
  _rawCwd = _enforceTrailingSlash(_rawCwd);
  _cachedWorkingDirectory = new Uri(scheme: 'file', path: _rawCwd);
  if (_logBuiltin) {
    _print('# Working Directory: $_cachedWorkingDirectory');
  }
  return _cachedWorkingDirectory;
}

String _rawScriptName;
Uri _cachedEntryPointScript;
Uri get _entryPointScript {
  if (_cachedEntryPointScript != null) {
    return _cachedEntryPointScript;
  }
  if (_workingDirectory == null) {
    throw 'No current working directory set.';
  }
  var scriptUri = Uri.parse(_rawScriptName);
  if (scriptUri.scheme != '') {
    // Script has a scheme, assume that it is fully formed.
    _cachedEntryPointScript = scriptUri;
  } else {
    // Script does not have a scheme, assume that it is a path,
    // resolve it against the working directory.
    _cachedEntryPointScript = _workingDirectory.resolve(_rawScriptName);
  }
  if (_logBuiltin) {
    _print('# Script entry point: $_rawScriptName -> $_cachedEntryPointScript');
  }
  return _cachedEntryPointScript;
}

_enforceTrailingSlash(String uri) {
  // Ensure we have a trailing slash character.
  if (!uri.endsWith('/')) {
    return '$uri/';
  }
  return uri;
}

_setWorkingDirectory(String cwd) {
  _rawCwd = cwd;
}

_resolveScriptUri(String scriptName) {
  _rawScriptName = scriptName;
}
