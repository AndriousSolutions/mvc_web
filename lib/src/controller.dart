// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// MVC framework
// hide runApp as it's not compatible with Flutter Web
// Error: Unsupported operation: dart:isolate is not supported on dart4web
export 'package:fluttery_framework/controller.dart' hide AppController;

/// utilities
export 'package:mvc_web/src/utils/web_utils.dart';
