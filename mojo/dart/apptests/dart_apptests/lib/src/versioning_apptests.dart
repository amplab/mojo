// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library versioning_apptests;

import 'dart:async';

import 'package:mojo_apptest/apptest.dart';
import 'package:mojo/application.dart';
import 'package:mojo/bindings.dart';
import 'package:mojo/core.dart';
import 'package:_mojo_for_test_only/mojo/test/versioning/versioning_test_client.mojom.dart';

tests(Application application, String url) {
  group('Versioning Apptests', () {
    test('Struct', () async {
      // The service side uses a newer version of Employee definition that
      // includes the 'birthday' field.

      // Connect to human resource database.
      var databaseProxy = new HumanResourceDatabaseProxy.unbound();
      application.connectToService(
          "mojo:versioning_test_service", databaseProxy);

      // Query database and get a response back (even though the client does not
      // know about the birthday field).
      bool retrieveFingerPrint = true;
      var response =
          await databaseProxy.queryEmployee(1, retrieveFingerPrint);
      expect(response.employee.employeeId, equals(1));
      expect(response.employee.name, equals("Homer Simpson"));
      expect(response.employee.department, equals(Department.dev));
      expect(response.fingerPrint, isNotNull);

      // Pass an Employee struct to the service side that lacks the 'birthday'
      // field.
      var newEmployee = new Employee();
      newEmployee.employeeId = 2;
      newEmployee.name = "Marge Simpson";
      newEmployee.department = Department.sales;
      response = await databaseProxy.addEmployee(newEmployee);
      expect(response.success, isTrue);

      // Query for employee #2.
      retrieveFingerPrint = false;
      response = await databaseProxy.queryEmployee(2, retrieveFingerPrint);
      expect(response.employee.employeeId, equals(2));
      expect(response.employee.name, equals("Marge Simpson"));
      expect(response.employee.department, equals(Department.sales));
      expect(response.fingerPrint, isNull);

      // Disconnect from database.
      databaseProxy.close();
    });

    test('QueryVersion', () async {
      // Connect to human resource database.
      var databaseProxy = new HumanResourceDatabaseProxy.unbound();
      application.connectToService(
          "mojo:versioning_test_service", databaseProxy);
      // Query the version.
      var version = await databaseProxy.ctrl.queryVersion();
      // Expect it to be 1.
      expect(version, equals(1));
      // Disconnect from database.
      databaseProxy.close();
    });

    test('RequireVersion', () async {
      // Connect to human resource database.
      var databaseProxy = new HumanResourceDatabaseProxy.unbound();
      application.connectToService(
          "mojo:versioning_test_service", databaseProxy);

      // Require version 1.
      databaseProxy.ctrl.requireVersion(1);
      expect(databaseProxy.ctrl.version, equals(1));

      // Query for employee #3.
      var retrieveFingerPrint = false;
      var response =
          await databaseProxy.queryEmployee(3, retrieveFingerPrint);

      // Got some kind of response.
      expect(response, isNotNull);

      // Require version 3 (which cannot be satisfied).
      databaseProxy.ctrl.requireVersion(3);
      expect(databaseProxy.ctrl.version, equals(3));

      // Query for employee #1, observe that the call fails.
      bool exceptionCaught = false;
      try {
        response = await databaseProxy.responseOrError(
            databaseProxy.queryEmployee(1, retrieveFingerPrint));
        fail('Exception should be thrown.');
      } catch (e) {
        exceptionCaught = true;
      }
      expect(exceptionCaught, isTrue);

      // No need to disconnect from database because we were disconnected by
      // the requireVersion control message.
    });

    test('CallNonexistentMethod', () async {
      // Connect to human resource database.
      var databaseProxy = new HumanResourceDatabaseProxy.unbound();
      application.connectToService(
          "mojo:versioning_test_service", databaseProxy);
      const fingerPrintLength = 128;
      var fingerPrint = new List(fingerPrintLength);
      for (var i = 0; i < fingerPrintLength; i++) {
        fingerPrint[i] = i + 13;
      }
      // Although the client side doesn't know whether the service side supports
      // version 1, calling a version 1 method succeeds as long as the service
      // side supports version 1.
      var response = await databaseProxy.attachFingerPrint(1, fingerPrint);
      expect(response.success, isTrue);

      // Calling a version 2 method (which the service side doesn't support)
      // closes the pipe.
      bool exceptionCaught = false;
      try {
        response = await databaseProxy
            .responseOrError(databaseProxy.listEmployeeIds());
        fail('Exception should be thrown.');
      } catch (e) {
        exceptionCaught = true;
      }
      expect(exceptionCaught, isTrue);

      // No need to disconnect from database because we were disconnected by
      // the call to a version 2 method.
    });
  });
}
