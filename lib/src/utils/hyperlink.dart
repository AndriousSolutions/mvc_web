// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends StatelessWidget {
  const Hyperlink(this.child, this.url, {Key? key}) : super(key: key);
  final Widget? child;
  final String? url;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () async {
          bool launching = url != null && url!.isNotEmpty;
          if (launching) {
            launching = await canLaunch(url!);
          }
          if (launching) {
            await launch(url!);
          }
        },
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide()),
          ),
          child: child ?? const Text('   '),
        ),
      );
}
