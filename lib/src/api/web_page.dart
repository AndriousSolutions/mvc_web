// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

/// extend this class instead of a StatefulWidget
class WebPageWidget extends WebPageBase {
  /// Always supply a 'WebPage' Controller.
  /// bool hasBottomBar will supply a bottom bar if already defined.
  WebPageWidget({
    Key? key,
    required this.controller,
    String? title,
    this.hasBottomBar,
  }) : super(controller, key: key ?? GlobalKey<StateX>(), title: title) {
    controller.widget = this;
  }

  /// Webpage controller
  final WebPageController controller;

  /// Display a bottom bar
  final bool? hasBottomBar;
}

/// Controller for the Webpage framework
abstract class WebPageController extends WebPageBaseController {
  /// Supply the Scaffold widget options.
  WebPageController({
    PreferredSizeWidget? appBar,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool? primary,
    DragStartBehavior? drawerDragStartBehavior,
    bool? extendBody,
    bool? extendBodyBehindAppBar,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool? drawerEnableOpenDragGesture,
    bool? endDrawerEnableOpenDragGesture,
    String? restorationId,
    ScrollPhysics? physics,
    State? state,
  }) : super(
          appBar: appBar,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: primary,
          drawerDragStartBehavior: drawerDragStartBehavior,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerScrimColor: drawerScrimColor,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          restorationId: restorationId,
          physics: physics,
          state: state,
        );

  /// Supply the widget through the controller.
  @override
  WebPageWidget? get widget {
    if (_widget == null) {
      final stateWidget = state?.widget;
      // Flutter errors if you cast a null
      if (stateWidget != null) {
        _widget = stateWidget as WebPageWidget;
      }
    }
    return _widget;
  }

  /// Free to explicitly assign the widget.
  set widget(WebPageWidget? widget) {
    if (widget != null) {
      _widget = widget;
    }
  }

  WebPageWidget? _widget;

  /// Supply the widget through the widget tree.
  T? webPageOf<T extends WebPageWidget>(BuildContext context) =>
      BasicScrollController.of<T>(context);

  /// Create your webpage or web screen
  /// or return null and implement the buildList() function instead.
  @override
  Widget? builder(BuildContext context);

  /// Create your webpage or web screen
  @override
  List<Widget>? buildList(BuildContext context) => null;

  /// Provide a appBar here as well.
  /// Otherwise a default AppBar is implemented.
  @override
  PreferredSizeWidget? onAppBar() => super.onAppBar();

  /// A bottom bar for every web page.
  // List<Widget>
  @override
  Column? onBottomBar(BuildContext context, [WebPageWidget? widget]) => null;

  /// Possible Screen overlay
  @override
  StackWidgetProperties? screenOverlay(BuildContext context) => null;

  @override
  List<Widget>? persistentFooterButtons(BuildContext context) => null;

  @override
  Widget? drawer(BuildContext context) => null;

  @override
  DrawerCallback? onDrawerChanged(BuildContext context) => null;

  @override
  Widget? endDrawer(BuildContext context) => null;

  @override
  DrawerCallback? onEndDrawerChanged(BuildContext context) => null;

  @override
  Widget? bottomNavigationBar(BuildContext context) => null;

  @override
  Widget? bottomSheet(BuildContext context) => null;

  /// Possible 'access bar' near the top of the screen
  List<Widget>? accessBar(BuildContext context, [WebPageWidget? widget]) =>
      null;
}

/// A variation of the WebPageWidget---no need to supply a controller
/// You can supply controller properties instead.
/// The Controller is created for you.
///
/// Uses the 'default' bottom bar if any is available.
class WebPageWrapper extends WebPageWidget {
  /// Supply the 'child' widget to display or a list of child widgets.
  /// Many are the Scaffold widget options.
  WebPageWrapper({
    Key? key,
    this.child,
    this.children,
    String? title,
    PreferredSizeWidget? appBar,
    WebPageController? controller,
    bool hasBottomBar = true,
    List<Widget>? Function(BuildContext context)? persistentFooterButtons,
    Widget? Function(BuildContext context)? drawer,
    DrawerCallback? Function(BuildContext context)? onDrawerChanged,
    Widget? Function(BuildContext context)? endDrawer,
    DrawerCallback? Function(BuildContext context)? onEndDrawerChanged,
    Widget? Function(BuildContext context)? bottomNavigationBar,
    Widget? Function(BuildContext context)? bottomSheet,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool? primary,
    DragStartBehavior? drawerDragStartBehavior,
    bool? extendBody,
    bool? extendBodyBehindAppBar,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool? drawerEnableOpenDragGesture,
    bool? endDrawerEnableOpenDragGesture,
    String? restorationId,
    ScrollPhysics? physics,
  }) : super(
          controller: controller ??
              WebPageControllerWrapper(
                persistentFooterButtons: persistentFooterButtons,
                drawer: drawer,
                onDrawerChanged: onDrawerChanged,
                endDrawer: endDrawer,
                onEndDrawerChanged: onEndDrawerChanged,
                bottomNavigationBar: bottomNavigationBar,
                bottomSheet: bottomSheet,
                appBar: appBar,
                backgroundColor: backgroundColor,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                primary: primary,
                drawerDragStartBehavior: drawerDragStartBehavior,
                extendBody: extendBody,
                extendBodyBehindAppBar: extendBodyBehindAppBar,
                drawerScrimColor: drawerScrimColor,
                drawerEdgeDragWidth: drawerEdgeDragWidth,
                drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
                endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
                restorationId: restorationId,
                physics: physics,
              ),
          key: key,
          title: title,
          hasBottomBar: hasBottomBar,
        );

  /// The child widget to be viewed in the webpage.
  final Widget? child;

  /// The list of child widgets. Above child widget takes precedence.
  final List<Widget>? children;
}

/// A predefined 'Webpage' controller
class WebPageControllerWrapper extends WebPageController {
  /// Many are Scaffold widget options.
  WebPageControllerWrapper({
    List<Widget>? Function(BuildContext context)? persistentFooterButtons,
    Widget? Function(BuildContext context)? drawer,
    DrawerCallback? Function(BuildContext context)? onDrawerChanged,
    Widget? Function(BuildContext context)? endDrawer,
    DrawerCallback? Function(BuildContext context)? onEndDrawerChanged,
    Widget? Function(BuildContext context)? bottomNavigationBar,
    Widget? Function(BuildContext context)? bottomSheet,
    PreferredSizeWidget? appBar,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool? primary,
    DragStartBehavior? drawerDragStartBehavior,
    bool? extendBody,
    bool? extendBodyBehindAppBar,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool? drawerEnableOpenDragGesture,
    bool? endDrawerEnableOpenDragGesture,
    String? restorationId,
    ScrollPhysics? physics,
  }) : super(
          appBar: appBar,
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          primary: primary,
          drawerDragStartBehavior: drawerDragStartBehavior,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerScrimColor: drawerScrimColor,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          restorationId: restorationId,
          physics: physics,
        ) {
    _persistentFooterButtons = persistentFooterButtons;
    _drawer = drawer;
    _onDrawerChanged = onDrawerChanged;
    _endDrawer = endDrawer;
    _onEndDrawerChanged = onEndDrawerChanged;
    _bottomNavigationBar = bottomNavigationBar;
    _bottomSheet = bottomSheet;
  }

  @override
  void initState() {
    super.initState();
    // This function gets called repeatedly. StatefulWidget gets rebuilt?
    _wrapper = widget as WebPageWrapper;
  }

  WebPageWrapper? _wrapper;

  @override
  Widget builder(BuildContext context) => _wrapper?.child ?? const SizedBox();

  @override
  List<Widget> buildList(BuildContext context) =>
      _wrapper?.children ?? [const SizedBox()];

  List<Widget>? Function(BuildContext context)? _persistentFooterButtons;
  Widget? Function(BuildContext context)? _drawer;
  DrawerCallback? Function(BuildContext context)? _onDrawerChanged;
  Widget? Function(BuildContext context)? _endDrawer;
  DrawerCallback? Function(BuildContext context)? _onEndDrawerChanged;
  Widget? Function(BuildContext context)? _bottomNavigationBar;
  Widget? Function(BuildContext context)? _bottomSheet;

  @override
  List<Widget>? persistentFooterButtons(BuildContext context) =>
      _persistentFooterButtons == null
          ? null
          : _persistentFooterButtons!(context);

  @override
  Widget? drawer(BuildContext context) =>
      _drawer == null ? null : _drawer!(context);

  @override
  DrawerCallback? onDrawerChanged(BuildContext context) =>
      _onDrawerChanged == null ? null : _onDrawerChanged!(context);

  @override
  Widget? endDrawer(BuildContext context) =>
      _endDrawer == null ? null : _endDrawer!(context);

  @override
  DrawerCallback? onEndDrawerChanged(BuildContext context) =>
      _onEndDrawerChanged == null ? null : _onEndDrawerChanged!(context);

  @override
  Widget? bottomNavigationBar(BuildContext context) =>
      _bottomNavigationBar == null ? null : _bottomNavigationBar!(context);

  @override
  Widget? bottomSheet(BuildContext context) =>
      _bottomSheet == null ? null : _bottomSheet!(context);
}

/// Wrap widget in an InteractiveViewer when appropriate.
Widget interactiveViewer(Widget widget, {bool wrap = true}) {
//
  if (App.inSmallScreen) {
//
    widget = InteractiveViewer(
      maxScale: 3,
      minScale: 1,
      child: widget,
    );
  }

  if (wrap && widget is! WebPageWidget) {
    widget = WebPageWrapper(child: widget);
  }

  return widget;
}

/// Display a child widget within a predefined Container widget
class WebPageContainer extends StatelessWidget {
  /// The child widget takes precedence but if not there
  /// the builder() function is called.
  const WebPageContainer({Key? key, this.child}) : super(key: key);

  ///
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final screenSize = App.screenSize;
    return Container(
      margin: EdgeInsets.fromLTRB(
        screenSize.width * 0.05,
        screenSize.height * 0.05,
        screenSize.width * 0.05,
        screenSize.height * 0.05,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: child ?? builder(context) ?? const SizedBox(),
    );
  }

  /// A subclass can override this function.
  Widget? builder(BuildContext context) => null;
}
