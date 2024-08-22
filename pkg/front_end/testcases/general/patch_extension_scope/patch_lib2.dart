// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore: import_internal_library
import 'dart:_internal';

@patch
class Class {
  void _method2() {
    namedExtensionMethod(); // Ok
    _namedExtensionPrivateMethod(); // Ok
    unnamedExtensionMethod(); // Ok
    _unnamedExtensionPrivateMethod(); // Ok

    namedInjectedExtensionMethod1(); // Ok
    _namedInjectedExtensionPrivateMethod1(); // Ok
    unnamedInjectedExtensionMethod1(); // Ok
    _unnamedInjectedExtensionPrivateMethod1(); // Ok

    namedInjectedExtensionMethod2(); // Ok
    _namedInjectedExtensionPrivateMethod2(); // Ok
    unnamedInjectedExtensionMethod2(); // Ok
    _unnamedInjectedExtensionPrivateMethod2(); // Ok
  }
}

void _method2(Class c) {
  c.namedExtensionMethod(); // Ok
  c._namedExtensionPrivateMethod(); // Ok
  c.unnamedExtensionMethod(); // Ok
  c._unnamedExtensionPrivateMethod(); // Ok

  c.namedInjectedExtensionMethod1(); // Ok
  c._namedInjectedExtensionPrivateMethod1(); // Ok
  c.unnamedInjectedExtensionMethod1(); // Ok
  c._unnamedInjectedExtensionPrivateMethod1(); // Ok

  c.namedInjectedExtensionMethod2(); // Ok
  c._namedInjectedExtensionPrivateMethod2(); // Ok
  c.unnamedInjectedExtensionMethod2(); // Ok
  c._unnamedInjectedExtensionPrivateMethod2(); // Ok
}

extension NamedInjectedExtension2 on Class /* Error */ {
  void namedInjectedExtensionMethod2() {}
  void _namedInjectedExtensionPrivateMethod2() {}
}

extension on Class {
  void unnamedInjectedExtensionMethod2() {}
  void _unnamedInjectedExtensionPrivateMethod2() {}
}
