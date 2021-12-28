// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class CounterAppModel {
  int get integer => _integer;
  int _integer = 0;
  int incrementCounter() => ++_integer;
}
