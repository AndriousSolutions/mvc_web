// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

/// The 'framework' of a typical Material Screen.
class ScaffoldScreenWidget extends BasicScrollStatefulWidget {
  const ScaffoldScreenWidget(ScaffoldScreenController controller,
      {Key? key, this.title})
      : super(controller, key: key);
  final String? title;

  PreferredSizeWidget? appBar(BuildContext context) => AppBar(
        title: Text(title ?? ''),
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(Icons.share),
        //     onPressed: () {},
        //   )
        // ],
      );
}

abstract class ScaffoldScreenController extends BasicScrollController {
  ScaffoldScreenController({
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary,
    this.drawerDragStartBehavior,
    this.extendBody,
    this.extendBodyBehindAppBar,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture,
    this.endDrawerEnableOpenDragGesture,
    this.restorationId,
  }) : super();

  @override
  void initState() {
    super.initState();
    // This function gets called repeatedly. StatefulWidget gets rebuilt?
    _widget = widget as ScaffoldScreenWidget;
  }

  ScaffoldScreenWidget? _widget;

  /// Provide a appBar
  PreferredSizeWidget? appBar(BuildContext context) => null;

  /// Provide the body of the Scaffold widget
  Widget? body(BuildContext context);

  List<Widget>? persistentFooterButtons(BuildContext context);

  Widget? drawer(BuildContext context);

  DrawerCallback? onDrawerChanged(BuildContext context);

  Widget? endDrawer(BuildContext context);

  DrawerCallback? onEndDrawerChanged(BuildContext context);

  Widget? bottomNavigationBar(BuildContext context);

  Widget? bottomSheet(BuildContext context);

  Color? backgroundColor;

  bool? resizeToAvoidBottomInset;

  bool? primary;

  DragStartBehavior? drawerDragStartBehavior;

  bool? extendBody;

  bool? extendBodyBehindAppBar;

  Color? drawerScrimColor;

  double? drawerEdgeDragWidth;

  bool? drawerEnableOpenDragGesture;

  bool? endDrawerEnableOpenDragGesture;

  String? restorationId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: appBar(context) ?? _widget!.appBar(context)
        // ??
        // PreferredSize(
        //   preferredSize: Size(screenSize.width, 1000),
        //   child: TopBarContents(opacity),
        // ),
        ,
        body: body(context),
        drawer: drawer(context),
        onDrawerChanged: onDrawerChanged(context),
        endDrawer: endDrawer(context),
        onEndDrawerChanged: onEndDrawerChanged(context),
        bottomNavigationBar: bottomNavigationBar(context),
        bottomSheet: bottomSheet(context),
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary ?? true,
        drawerDragStartBehavior:
            drawerDragStartBehavior ?? DragStartBehavior.start,
        extendBody: extendBody ?? false,
        extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture ?? true,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture ?? true,
        restorationId: restorationId,
      );
}
