// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

/// The 'framework' of a typical Material Screen.
class ScaffoldScreenWidget extends BasicScrollStatefulWidget {
  /// Supply a String for the title.
  const ScaffoldScreenWidget(ScaffoldScreenController controller,
      {Key? key, this.title})
      : super(controller, key: key);

  ///
  final String? title;
}

/// Creates the Scaffold widget.
abstract class ScaffoldScreenController extends BasicScrollController {
  /// Supply many Scaffold widget
  ScaffoldScreenController({
    this.appBar,
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
    State? state,
  }) : super(state);

  /// Provide a appBar using this function instead.
  PreferredSizeWidget? onAppBar() {
    final _widget = widget as ScaffoldScreenWidget;
    return _widget.title == null
        ? null
        : AppBar(
            title: Text(_widget.title ?? ''),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: screenSize.width * 0.05),
                child: const BackButton(),
              )
            ],
          );
  }

  /// Provide the body of the Scaffold widget
  Widget? body(BuildContext context);

  ///
  List<Widget>? persistentFooterButtons(BuildContext context);

  ///
  Widget? drawer(BuildContext context);

  ///
  DrawerCallback? onDrawerChanged(BuildContext context);

  ///
  Widget? endDrawer(BuildContext context);

  ///
  DrawerCallback? onEndDrawerChanged(BuildContext context);

  ///
  Widget? bottomNavigationBar(BuildContext context);

  ///
  Widget? bottomSheet(BuildContext context);

  ///
  final PreferredSizeWidget? appBar;

  ///
  final Color? backgroundColor;

  ///
  final bool? resizeToAvoidBottomInset;

  ///
  final bool? primary;

  ///
  final DragStartBehavior? drawerDragStartBehavior;

  ///
  final bool? extendBody;

  ///
  final bool? extendBodyBehindAppBar;

  ///
  final Color? drawerScrimColor;

  ///
  final double? drawerEdgeDragWidth;

  ///
  final bool? drawerEnableOpenDragGesture;

  ///
  final bool? endDrawerEnableOpenDragGesture;

  ///
  final String? restorationId;

  @override
  Widget build(BuildContext context) => _ScaffoldBuilder(controller: this);

  /// The Scaffold used by this webpage.
  Widget? buildScaffold(BuildContext context) => Scaffold(
        appBar: appBar ?? onAppBar(),
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

/// Present the Scaffold widget to its own State object.
class _ScaffoldBuilder extends StatefulWidget {
  const _ScaffoldBuilder({Key? key, required this.controller})
      : super(key: key);
  final ScaffoldScreenController controller;
  @override
  State<StatefulWidget> createState() => _ScaffoldBuilderState();
}

/// Link this as a dependency to the App's InheritedWidget.
class _ScaffoldBuilderState extends State<_ScaffoldBuilder> {
  //
  @override
  void initState() {
    super.initState();
    con = widget.controller;
  }

  late ScaffoldScreenController con;

  @override
  Widget build(BuildContext context) {
    // Link this to an InheritedWidget.
    con.widgetInherited(context);
    return con.buildScaffold(context)!;
  }
}
