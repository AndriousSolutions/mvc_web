// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

abstract class QuickAccessBar extends StatefulWidget {
  const QuickAccessBar({Key? key}) : super(key: key);

  ///
  BasicScrollStatefulWidget get screen;

  ///
  Map<String, double> get pages;

  @override
  _QuickAccessBarState createState() => _QuickAccessBarState();
}

class _QuickAccessBarState extends State<QuickAccessBar> {
  List<Widget> rowElements = [];

  @override
  void initState() {
    super.initState();
    scrollController = widget.screen.scrollController;
    items = widget.pages.keys.toList();
    _isHovering = [
      ...Iterable<bool>.generate(items.length, (int pageIndex) => false)
    ];
  }

  late List<String> items;
  late List<bool> _isHovering;

  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
//    final _screenSize = MediaQuery.of(context).size;
    final _screenSize = App.screenSize;
    // Determine if displayed in a small screen.
//    final smallScreen = ResponsiveWidget.isSmallScreen(context);
    final smallScreen = App.inSmallScreen;
    return Center(
      heightFactor: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: _screenSize.height * 0.40,
          left: smallScreen ? _screenSize.width / 12 : _screenSize.width / 5,
          right: smallScreen ? _screenSize.width / 12 : _screenSize.width / 5,
        ),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: _screenSize.height / 50,
              bottom: _screenSize.height / 50,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: generateRowElements(_screenSize),
            ),
          ),
        ),
      ),
    );
  }

  /// Scroll to that particular widget by it's GlobalKey
//   void _scrollTo(GlobalKey<State<StatefulWidget>> page) {
//     final context = page.currentContext;
//     if (context != null && scrollController != null) {
//       scrollController!.position.ensureVisible(
//         context.findRenderObject()!,
// //        alignment: 0.5, // Aligns the image in the middle.
//         duration: const Duration(milliseconds: 120), // So it does not jump.
//       );
//     }
//   }

  void _animateTo(double offset) {
    //
    if (scrollController != null) {
      scrollController!.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<Widget> generateRowElements(Size screenSize) {
    rowElements.clear();
    for (int i = 0; i < items.length; i++) {
      final Widget elementTile = InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onHover: (value) {
          setState(() {
            value ? _isHovering[i] = true : _isHovering[i] = false;
          });
        },
        onTap: () => _animateTo(widget.pages[items[i]]!),
        child: Text(
          items[i],
          style: TextStyle(
            color: _isHovering[i]
                ? Theme.of(context).primaryTextTheme.button!.decorationColor
                : Theme.of(context).primaryTextTheme.button!.color,
          ),
        ),
      );
      final Widget spacer = SizedBox(
        height: screenSize.height / 20,
        child: VerticalDivider(
          width: 1,
          color: Colors.blueGrey[100],
          thickness: 1,
        ),
      );
      rowElements.add(elementTile);
      if (i < items.length - 1) {
        rowElements.add(spacer);
      }
    }
    return rowElements;
  }
}
