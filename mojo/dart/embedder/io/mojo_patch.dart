// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:nativewrappers';

import 'dart:_mojo/application.dart';
import 'dart:_mojo/bindings.dart';
import 'dart:_mojo/core.dart';
import 'dart:_mojo/mojo/network_error.mojom.dart';
import 'dart:_mojo_services/mojo/host_resolver.mojom.dart';
import 'dart:_mojo_services/mojo/net_address.mojom.dart';
import 'dart:_mojo_services/mojo/network_service.mojom.dart';
import 'dart:_mojo_services/mojo/tcp_bound_socket.mojom.dart';
import 'dart:_mojo_services/mojo/tcp_connected_socket.mojom.dart';
import 'dart:_mojo_services/mojo/tcp_server_socket.mojom.dart';
import 'dart:_mojo_services/mojo/files/file.mojom.dart';
import 'dart:_mojo_services/mojo/files/files.mojom.dart';
import 'dart:_mojo_services/mojo/files/directory.mojom.dart';
import 'dart:_mojo_services/mojo/files/ioctl.mojom.dart';
import 'dart:_mojo_services/mojo/files/types.mojom.dart' as types;

// When developing, set fileSystemDeveloper to true and the file system will
// persist under ~/MojoAppPersistentCaches/.
const bool fileSystemDeveloper = false;
const String fileSystemName =
    fileSystemDeveloper ? 'app_persistent_cache' : null;

// System temp path relative to the root directory.
const String systemTempPath = 'tmp';

//
// Mojo objects and helper functions used by the 'dart:io' library.
//
int _networkServiceHandle;
int _filesServiceHandle;
NetworkServiceProxy _networkService;
HostResolverProxy _hostResolver;
FilesProxy _files;
DirectoryProxy _rootDirectory;
DirectoryProxy _systemTempDirectory;

void _initialize(
    int networkServiceHandle, int filesServiceHandle, String scriptPath) {
  if (networkServiceHandle != MojoHandle.INVALID) {
    _networkServiceHandle = networkServiceHandle;
  }
  if (filesServiceHandle != MojoHandle.INVALID) {
    _filesServiceHandle = filesServiceHandle;
  }
  // TODO(floitsch): do this lazily once _Platform.script is a getter.
  _Platform.script = Uri.parse(scriptPath);
}

void _shutdown() {
  if (_networkServiceHandle != null) {
    // Network service proxies were never initialized. Create a handle
    // and close it.
    var handle = new MojoHandle(_networkServiceHandle);
    _networkServiceHandle = null;
    handle.close();
  }
  if (_filesServiceHandle != null) {
    // File system proxies were never initialized. Create a handle and close it.
    var handle = new MojoHandle(_filesServiceHandle);
    _filesServiceHandle = null;
    handle.close();
  }
  _closeProxies();
}

/// Close any active proxies.
_closeProxies() {
  if (_networkService != null) {
    _networkService.close(immediate: true);
    _networkService = null;
  }
  if (_hostResolver != null) {
    _hostResolver.close(immediate: true);
    _hostResolver = null;
  }
  if (_files != null) {
    _files.close(immediate: true);
    _files = null;
  }
  if (_rootDirectory != null) {
    _rootDirectory.close(immediate: true);
    _rootDirectory = null;
  }
  if (_systemTempDirectory != null) {
    _systemTempDirectory.close(immediate: true);
    _systemTempDirectory = null;
  }
}

/// Get the singleton NetworkServiceProxy.
NetworkServiceProxy _getNetworkService() {
  if (_networkService != null) {
    return _networkService;
  }
  _networkService = new NetworkServiceProxy.fromHandle(
      new MojoHandle(_networkServiceHandle).pass());
  _networkServiceHandle = null;
  return _networkService;
}

/// Get the singleton HostResolverProxy.
HostResolverProxy _getHostResolver() {
  if (_hostResolver != null) {
    return _hostResolver;
  }
  var networkService = _getNetworkService();
  if (networkService == null) {
    return null;
  }
  _hostResolver = new HostResolverProxy.unbound();
  networkService.createHostResolver(_hostResolver);
  // Remove the host resolver's handle from the open set because it is not
  // under application control and does not affect isolate shutdown.
  _hostResolver.ctrl.endpoint.handle.pass();
  return _hostResolver;
}

/// Get the singleton FilesProxy.
FilesProxy _getFiles() {
  if (_files != null) {
    return _files;
  }
  _files = new FilesProxy.fromHandle(
      new MojoHandle(_filesServiceHandle).pass());
  _filesServiceHandle = null;
  return _files;
}

/// Get the singleton DirectoryProxy for the root directory.
Future<DirectoryProxy> _getRootDirectory() async {
  if (_rootDirectory != null) {
    return _rootDirectory;
  }
  FilesProxy files = _getFiles();
  assert(files != null);
  _rootDirectory = new DirectoryProxy.unbound();
  var response =
      await files.openFileSystem(fileSystemName, _rootDirectory);
  // Remove the root directory's handle from the open set because it is not
  // under application control and does not affect isolate shutdown.
  _rootDirectory.ctrl.endpoint.handle.pass();

  // Ensure system temporary directory exists before returning the root
  // directory.
  await _getSystemTempDirectory();
  return _rootDirectory;
}

/// Get the singleton DirectoryProxy for the system temp directory.
Future<DirectoryProxy> _getSystemTempDirectory() async {
  if (_systemTempDirectory != null) {
    return _systempTempDirectory;
  }
  DirectoryProxy rootDirectory = await _getRootDirectory();
  int flags = types.kOpenFlagRead |
              types.kOpenFlagWrite |
              types.kOpenFlagCreate;
  _systemTempDirectory = new DirectoryProxy.unbound();
  var response =
      await rootDirectory.openDirectory(systemTempPath,
                                        _systemTempDirectory,
                                        flags);
  assert(response.error == types.Error.ok);
  // Remove the system temp directory's handle from the open set because it
  // is not under application control and does not affect isolate shutdown.
  _systemTempDirectory.ctrl.endpoint.handle.pass();
  return _systemTempDirectory;
}

/// Static utility methods for converting between 'dart:io' and
/// 'mojo:network_service' structs.
class _NetworkServiceCodec {
  /// Returns a string representation of an ip address encoded in [address].
  /// Supports both IPv4 and IPv6.
  static String _addressToString(List<int> address) {
    String r = '';
    if (address == null) {
      return r;
    }
    bool ipv4 = address.length == 4;
    if (ipv4) {
      for (var i = 0; i < 4; i++) {
        var digit = address[i].toString();
        var divider = (i != 3) ? '.' : '';
        r += '${digit}${divider}';
      }
    } else {
      for (var i = 0; i < 16; i += 2) {
        var first = '';
        if (address[i] != 0) {
          first = address[i].toRadixString(16).padLeft(2, '0');
        }
        var second = address[i + 1].toRadixString(16).padLeft(2, '0');
        var digit = '$first$second';
        var divider = (i != 14) ? ':' : '';
        r += '${digit}${divider}';
      }
    }
    return r;
  }

  /// Convert from [NetAddress] to [InternetAddress].
  static InternetAddress _fromNetAddress(NetAddress netAddress) {
    if (netAddress == null) {
      return null;
    }
    var address;
    if (netAddress.family == NetAddressFamily.ipv4) {
      address = netAddress.ipv4.addr;
    } else if (netAddress.family == NetAddressFamily.ipv6) {
      address = netAddress.ipv6.addr;
    } else {
      return null;
    }
    assert(address != null);
    var addressString = _addressToString(address);
    return new InternetAddress(addressString);
  }

  static int _portFromNetAddress(NetAddress netAddress) {
    if (netAddress == null) {
      return null;
    }
    if (netAddress.family == NetAddressFamily.ipv4) {
      return netAddress.ipv4.port;
    } else if (netAddress.family == NetAddressFamily.ipv6) {
      return netAddress.ipv6.port;
    } else {
      return null;
    }
  }

  /// Convert from [InternetAddress] to [NetAddress].
  static NetAddress _fromInternetAddress(InternetAddress internetAddress,
                                         [port]) {
    if (internetAddress == null) {
      return null;
    }
    var netAddress = new NetAddress();
    var rawAddress = internetAddress.rawAddress;
    if (rawAddress.length == 4) {
      netAddress.family = NetAddressFamily.ipv4;
      netAddress.ipv4 = new NetAddressIPv4();
      netAddress.ipv4.addr = new List.from(rawAddress, growable: false);
      if (port != null) {
        netAddress.ipv4.port = port;
      }
    } else {
      assert(rawAddress.length == 16);
      netAddress.family = NetAddressFamily.ipv6;
      netAddress.ipv6 = new NetAddressIPv6();
      netAddress.ipv6.addr = new List.from(rawAddress, growable: false);
      if (port != null) {
        netAddress.ipv6.port = port;
      }
    }
    return netAddress;
  }
}

/// Static utility methods for dealing with 'mojo:network_service'.
class _NetworkService {
  /// Return a [NetAddress] for localhost:port.
  static NetAddress _localhostIpv4([int port = 0]) {
    var addr = new NetAddress();
    addr.family = NetAddressFamily.ipv4;
    addr.ipv4 = new NetAddressIPv4();
    addr.ipv4.addr = [127, 0, 0, 1];
    addr.ipv4.port = port;
    return addr;
  }

  /// Return a [NetAddress] for localhost:port.
  static NetAddress _localHostIpv6([int port = 0]) {
    var addr = new NetAddress();
    addr.family = NetAddressFamily.ipv6;
    addr.ipv6 = new NetAddressIPv6();
    addr.ipv6.addr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
    addr.ipv6.port = port;
    return addr;
  }

  static bool _okay(NetworkError error) {
    if (error == null) {
      return true;
    }
    return error.code == 0;
  }

  static _throwOnError(NetworkError error) {
    if (_okay(error)) {
      return;
    }
    throw new OSError(error.description, error.code);
  }
}

