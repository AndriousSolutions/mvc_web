// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mvc_web/src/view.dart';

///
class WebScrollbar extends StatefulWidget {
  /// Supply a child widget and a Scroll controller.
  const WebScrollbar({
    required this.child,
    required this.controller,
    this.heightFraction = 0.20,
    this.width = 8,
    this.color = Colors.black45,
    this.backgroundColor = Colors.black12,
    this.isAlwaysShown = false,
    Key? key,
  })  : assert(heightFraction < 1.0 && heightFraction > 0.0),
        super(key: key);

  ///
  final Widget child;

  ///
  final ScrollController controller;

  ///
  final double heightFraction;

  ///
  final double width;

  ///
  final Color color;

  ///
  final Color backgroundColor;

  ///
  final bool isAlwaysShown;

  @override
  _WebScrollbarState createState() => _WebScrollbarState();
}

class _WebScrollbarState extends State<WebScrollbar> {
  double _scrollPosition = 0;
  late Timer timer;

  ScrollPosition get position => _position!;
  ScrollPosition? _position;

  @override
  void initState() {
    // Call build() with every scroll
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          _scrollPosition = widget.controller.offset;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //
    final screenSize = MediaQuery.of(context).size;

    final double _scrollerHeight = screenSize.height * widget.heightFraction;

    double? topMargin;

    final ScrollController controller = widget.controller;

    if (controller.hasClients) {
      final positions = controller.positions;
      if (positions.length > 1) {
        final scrollPosition = positions.first;
        controller.detach(scrollPosition);
        // It's important that we not dispose the old position until after the
        // viewport has had a chance to unregister its listeners from the old
        // position. So, schedule a microtask to do it.
        scheduleMicrotask(scrollPosition.dispose);
      }
      if (controller.position.hasContentDimensions) {
        final position = _scrollPosition / controller.position.maxScrollExtent;
        topMargin =
            (screenSize.height * position) - (_scrollerHeight * position);
      }
    }

    if (topMargin == null || topMargin == double.nan || topMargin < 0) {
      topMargin = 1;
    }

    return widget.child;
  }
}
