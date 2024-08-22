// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:developer';

import 'package:test/test.dart';
import 'package:vm_service/vm_service.dart';

import 'common/service_test_common.dart';
import 'common/test_helper.dart';

// AUTOGENERATED START
//
// Update these constants by running:
//
// dart pkg/vm_service/test/update_line_numbers.dart <test.dart>
//
const LINE_A = 27;
const LINE_B = 29;
const LINE_C = 31;
// AUTOGENERATED END

void warmup() {
  Timer timer = Timer(const Duration(days: 30), () {});
  debugger(); // LINE_A
  timer.cancel();
  debugger(); // LINE_B
  timer = Timer(const Duration(days: 30), () {});
  debugger(); // LINE_C
  timer.cancel();
}

late Set<int> originalPortIds;
late int timerPortId;

final tests = <IsolateTest>[
  hasPausedAtStart,
  (VmService service, IsolateRef isolateRef) async {
    final isolateId = isolateRef.id!;
    final originalPorts = (await service.getPorts(isolateId)).ports!;
    originalPortIds = {
      for (int i = 0; i < originalPorts.length; ++i) originalPorts[i].portId!,
    };
  },
  resumeIsolate,
  hasStoppedAtBreakpoint,
  stoppedAtLine(LINE_A),
  (VmService service, IsolateRef isolateRef) async {
    // Determine the ID of the timer port.
    final isolateId = isolateRef.id!;
    final ports = (await service.getPorts(isolateId)).ports!;
    timerPortId = ports
        .firstWhere(
          (p) => !originalPortIds.contains(p.portId!),
        )
        .portId!;
  },
  resumeIsolate,
  hasStoppedAtBreakpoint,
  stoppedAtLine(LINE_B),
  (VmService service, IsolateRef isolateRef) async {
    // After cancelling the timer, there should be no active timers left.
    // The timer port should be inactive and not reported.
    final isolateId = isolateRef.id!;
    final ports = (await service.getPorts(isolateId)).ports!;
    for (final port in ports) {
      if (port.portId! == timerPortId) {
        fail('Timer port should no longer be active');
      }
    }
  },
  resumeIsolate,
  hasStoppedAtBreakpoint,
  stoppedAtLine(LINE_C),
  (VmService service, IsolateRef isolateRef) async {
    // After setting a new timer, the timer port should be active and have the same
    // port ID as before as the original port is still being used.
    final isolateId = isolateRef.id!;
    final ports = (await service.getPorts(isolateId)).ports!;
    bool foundTimerPort = false;
    for (final port in ports) {
      if (port.portId! == timerPortId) {
        foundTimerPort = true;
        break;
      }
    }
    expect(foundTimerPort, true);
  },
];

void main([args = const <String>[]]) => runIsolateTests(
      args,
      tests,
      'validate_timer_port_behavior_test.dart',
      pauseOnStart: true,
      testeeConcurrent: warmup,
    );
