// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

import 'package:url_launcher/url_launcher.dart';

/// Calls the child widget to be displayed in the webpage
abstract class WebPageBase extends ScaffoldScreenWidget
    with WebPageFeaturesMixin {
  /// 'Nothing' is displayed if a Webpage controller is not provided.
  WebPageBase(this.webPageBaseController, {Key? key, String? title})
      : super(webPageBaseController, key: key, title: title);

  ///
  final WebPageBaseController webPageBaseController;

  /// Create the webpage using this widget if necessary.
  Widget builder(BuildContext context) {
    Widget widget;
    try {
      /// Retrieve the main content if any.
      widget = webPageBaseController.builder(context) ?? const SizedBox();
    } catch (ex, stack) {
      widget = const SizedBox();
      FlutterError.reportError(FlutterErrorDetails(
        exception: ex,
        stack: stack,
        library: 'webpage_base.dart',
        context: ErrorDescription('Widget? builder(BuildContext context) {'),
      ));
      // Make the error known if under development.
      if (App.inDebugger) {
        rethrow;
      }
    }
    return widget;
  }

  /// Create a list of Widgets for a  webpage using this widget if necessary.
  List<Widget> buildList(BuildContext context) {
    List<Widget> list;
    try {
      /// Retrieve the main content if any.
      list = webPageBaseController.buildList(context) ?? [const SizedBox()];
    } catch (ex, stack) {
      list = [const SizedBox()];
      FlutterError.reportError(FlutterErrorDetails(
        exception: ex,
        stack: stack,
        library: 'webpage_base.dart',
        context: ErrorDescription('Widget? builder(BuildContext context) {'),
      ));
      // Make the error known if under development.
      if (App.inDebugger) {
        rethrow;
      }
    }
    return list;
  }

  // /// The 'child' widget containing the core of the screen's content.
  // List<Widget>? child(BuildContext context, [WebPageWidget? widget]) =>
  //     webPageBaseController.child(context, widget);

  /// Possible Screen overlay
  StackWidgetProperties? screenOverlay(BuildContext context) =>
      webPageBaseController.screenOverlay(context);

  /// Possible bottom bar
  Column? bottomBar(BuildContext context, [WebPageWidget? widget]) =>
      webPageBaseController.onBottomBar(context, widget);

  /// Supply a 'popup' screen that zooms in on the screen.
  Widget popupScreen(
    BuildContext context, {
    required String title,
    required String text,
    required String name,
    Widget? image,
    bool interactive = true,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    EdgeInsetsGeometry? padding,
    CrossAxisAlignment? crossAxisAlignment,
    TextStyle? titleStyle,
    TextStyle? textStyle,
  }) =>
      webPageBaseController.popupScreen(
        context,
        title: title,
        text: text,
        name: name,
        image: image,
        interactive: interactive,
        margin: margin,
        decoration: decoration,
        padding: padding,
        crossAxisAlignment: crossAxisAlignment,
        titleStyle: titleStyle,
        textStyle: textStyle,
      );
}

/// The Webpage controller for the WebPageBase StatefulWidget
abstract class WebPageBaseController extends ScaffoldScreenController {
  /// Many the Scaffold widget options.
  WebPageBaseController({
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
    this.scrollDirection,
    this.reverse,
    this.padding,
    this.physics,
    this.dragStartBehavior,
    this.clipBehavior,
    this.keyboardDismissBehavior,
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
          state: state,
        );

  /// The axis along which the scroll view scrolls.
  final Axis? scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  final bool? reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  /// Decribe the 'drag' behaviour.
  final DragStartBehavior? dragStartBehavior;

  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  /// How the keyboard is removed from the screen.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  /// Create your webpage or web screen
  /// or return null and implement the buildList() function instead.
  Widget? builder(BuildContext context);

  /// Create your webpage or web screen
  List<Widget>? buildList(BuildContext context) => null;

  /// Provide a appBar here as well.
  /// Otherwise a default AppBar is implemented.
  @override
  PreferredSizeWidget? onAppBar() => super.onAppBar();

  /// A bottom bar for every web page.
  // List<Widget>
  Column? onBottomBar(BuildContext context, [WebPageWidget? widget]) => null;

  /// This is the 'default' bottom bar if any.
  BottomBar? get appBottomBar => _appBottomBar;
  static BottomBar? _appBottomBar;

  // /// The 'child' widget containing the core of the screen's content.
  // List<Widget>? child(BuildContext context, [WebPageWidget? widget]);

  /// Possible Screen overlay
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

  /// Provide the body of the webpage
  @override
  Widget body(BuildContext context) {
    //
    StackWidgetProperties? stackProps;

    Widget? _child;

    try {
      /// Retrieve the main content if any.
      _child = scrollChild(context);
    } catch (ex, stack) {
      _child = null;
      FlutterError.reportError(FlutterErrorDetails(
        exception: ex,
        stack: stack,
        library: 'webpage_base.dart',
        context: ErrorDescription('_child = scrollChild(context)'),
      ));
      // Make the error known if under development.
      if (App.inDebugger) {
        rethrow;
      }
    }

    Widget? _overlay;

    ///
    stackProps = screenOverlay(context);

    /// Display the overlay if it exists
    if (_child == null) {
      _child = stackProps?.child;
    } else {
      _overlay = stackProps?.child;
    }

    /// If there is indeed no content to be displayed.
    if (_child == null) {
      //
      final FlutterErrorDetails details = FlutterErrorDetails(
        exception: Exception('No web content was supplied?'),
        library: 'webpage_base.dart',
        context: ErrorDescription(
            "Please, look to the 'controller' for providing content."),
      );

      FlutterError.reportError(details);
      // Notify the developer. Leave an 'empty screen' in production.
      if (App.inDebugger) {
        _child = ErrorWidget.builder(details);
      }
    } else {
      //
      _child = SingleChildScrollView(
        scrollDirection: scrollDirection ?? Axis.vertical,
        reverse: reverse ?? false,
        padding: padding,
        primary: false,
        physics: physics ?? const ClampingScrollPhysics(),
        controller: scrollController,
        dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
        clipBehavior: clipBehavior ?? Clip.hardEdge,
        keyboardDismissBehavior:
            keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
        child: _child,
      );

      ///
      if (_overlay != null) {
        _child = Stack(
          alignment: stackProps?.alignment ?? AlignmentDirectional.topStart,
          textDirection: stackProps?.textDirection,
          fit: stackProps?.fit ?? StackFit.loose,
          clipBehavior: stackProps?.clipBehavior ?? Clip.hardEdge,
          children: [
            _child,
            _overlay,
          ],
        );
      }
    }
    return WebScrollbar(
      color: Colors.blueGrey,
      backgroundColor: Colors.blueGrey.withOpacity(0.3),
      width: 16,
      heightFraction: 0.3,
      controller: scrollController,
      child: _child ?? const SizedBox(),
    );
  }

  /// The widget passed to the SingleChildScrollView in the parent class.
  Widget? scrollChild(BuildContext context) {
    /// Reference to the Webpage StatefulWidget
    final WebPageWidget? webPage =
        widget is WebPageWidget ? widget as WebPageWidget : null;

    /// The list of widgets finally displayed in the Webpage.
    final List<Widget> list = [];

    // Retrieve the first and foremost webpage
    final Widget? _widget = builder(context);

    if (_widget != null) {
      list.add(_widget);
    }

    // Retrieve a list of widgets that make up a webpage
    final List<Widget>? _list = buildList(context);

    if (_list != null && _list.isNotEmpty) {
      list.addAll(_list);
    }

    if (list.isEmpty) {
      list.add(const SizedBox());
    }

    // Supply a bottom bar or not?
    if (webPage != null &&
        (webPage.hasBottomBar == null || webPage.hasBottomBar == true)) {
      //
      Column? bottomColumn = webPage.bottomBar(context, webPage);

      bottomColumn ??= onBottomBar(context, webPage);

      BottomBar? _bottomBar;
      // Was a bottom bar column generated?
      if (bottomColumn != null) {
        //
        _bottomBar = BottomBar(children: bottomColumn);

        // Save the bottom bar for future use.
        _appBottomBar ??= _bottomBar;
        //
      } else if (_appBottomBar != null) {
        //
        _bottomBar = _appBottomBar!;
      }

      if (_bottomBar != null) {
        //
        list.add(SizedBox(height: screenSize.height / 10));

        list.add(_bottomBar);
      }
    }
    return Column(children: list);
  }

  /// Provide a 'popup' screen.
  Widget popupScreen(
    BuildContext context, {
    required String title,
    required String text,
    required String name,
    Widget? image,
    bool interactive = true,
    EdgeInsetsGeometry? margin,
    Decoration? decoration,
    EdgeInsetsGeometry? padding,
    CrossAxisAlignment? crossAxisAlignment,
    TextStyle? titleStyle,
    TextStyle? textStyle,
    bool? hasBottomBar,
  }) {
    final _screenSize = App.screenSize;
    final _smallScreen = App.inSmallScreen;

    Widget popImage;

    popImage = Image.asset(
      name,
      fit: BoxFit.cover,
    );

    if (interactive) {
      popImage = InteractiveViewer(
        maxScale: 3,
        minScale: 1,
        child: popImage,
      );
    }

    return Container(
      margin: margin ??
          EdgeInsets.fromLTRB(
            _screenSize.width * (_smallScreen ? 0 : 0.2),
            _screenSize.height * (_smallScreen ? 0.1 : 0.2),
            _screenSize.width * (_smallScreen ? 0.0 : 0.2),
            _screenSize.height * (_smallScreen ? 0.1 : 0.2),
          ),
      decoration: decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
      padding: padding ?? EdgeInsets.all(_smallScreen ? 10 : 30),
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 18),
          AutoSizeText(
            text,
            style: textStyle ?? const TextStyle(fontSize: 16),
          ),
          SizedBox(height: _screenSize.height * 0.05),
          InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () => PopupPage.window<void>(
              context,
              (_) => Center(
                child: popImage,
              ),
              hasBottomBar: hasBottomBar,
            ),
            child: image ??
                Padding(
                  padding: EdgeInsets.all(_smallScreen ? 0 : 40),
                  child: Image.asset(name),
                ),
          ),
        ],
      ),
    );
  }
}

/// Containing standard functionality for a typical webpage.
mixin WebPageFeaturesMixin {
  /// Display an external webpage.
  Future<bool> uriBrowse(
    String? uri, {
    bool? forceSafariVC,
    bool? forceWebView,
    bool? enableJavaScript,
    bool? enableDomStorage,
    bool? universalLinksOnly,
    Map<String, String>? headers,
    Brightness? statusBarBrightness,
    String? webOnlyWindowName,
  }) async {
    //
    bool browse;
    //   if (await canLaunch(url)) {
    if (uri == null) {
      browse = false;
    } else {
      try {
        await launch(
          uri,
          forceSafariVC: forceSafariVC,
          forceWebView: forceWebView ?? false,
          enableJavaScript: enableJavaScript ?? false,
          enableDomStorage: enableDomStorage ?? false,
          universalLinksOnly: universalLinksOnly ?? false,
          headers: headers ?? const <String, String>{},
          statusBarBrightness: statusBarBrightness,
          webOnlyWindowName: webOnlyWindowName,
        );
        browse = true;
      } catch (e) {
        browse = false;
      }
    }
    return browse;
  }
}

/// Provide a child Widget a 'fractional' size when displayed.
class FractionallySizedWidget extends StatelessWidget {
  /// The fractional value and child is required.
  const FractionallySizedWidget({
    Key? key,
    required this.widthFactor,
    required this.child,
  }) : super(key: key);

  /// Size this factor
  final double widthFactor;

  /// The child widget displayed.
  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: widthFactor,
          child: child,
        ),
      );
}

/// Supply a list of properties in one object.
class StackWidgetProperties {
  /// All are optional except the child widget.
  StackWidgetProperties({
    this.alignment,
    this.textDirection,
    this.fit,
    this.clipBehavior,
    required this.child,
  });

  ///
  final AlignmentGeometry? alignment;

  ///
  final TextDirection? textDirection;

  ///
  final StackFit? fit;

  ///
  final Clip? clipBehavior;

  ///
  final Widget? child;
}

/// Popup window
/// Provides an animated popup.
class PopupPage extends WebPageWidget {
  /// Many options are for the Scaffold Widget.
  PopupPage({
    Key? key,
    required this.inBuilder,
    this.initState,
    this.dispose,
    String? title,
    PreferredSizeWidget? appBar,
    bool? hasBottomBar,
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
          controller: BuilderPageController(
            inBuilder: inBuilder,
            initStateFunc: initState,
            disposeFunc: dispose,
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
            popup: true,
          ),
          key: key,
          title: title,
          hasBottomBar: hasBottomBar ?? false,
        );

  /// Function builds the child widget
  final WidgetBuilder inBuilder;

  ///
  final void Function()? initState;

  ///
  final void Function()? dispose;

  @override
  String get title => '';

  // @override
  // List<Widget>? child(BuildContext context, [WebPageWidget? widget]) =>
  //     [builder(context)];

  /// Create a popup window
  static Future<T?> window<T>(
    BuildContext parentContext,
    WidgetBuilder child, {
    String? title,
    PreferredSizeWidget? appBar,
    bool? hasBottomBar,
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
    Curve? curve,
    void Function()? initState,
    void Function()? dispose,
  }) async {
    final T? result = await Navigator.of(parentContext).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => PopupPage(
          inBuilder: (_) => child(parentContext),
          initState: initState,
          dispose: dispose,
          title: title,
          appBar: appBar,
          hasBottomBar: hasBottomBar,
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
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final rectAnimation = _createTween(parentContext)
              .chain(CurveTween(curve: curve ?? Curves.ease))
              .animate(animation);
          return Stack(
            children: [
              PositionedTransition(rect: rectAnimation, child: child),
            ],
          );
        },
      ),
    );
    return result;
  }

  /// Define the transition used in the animation
  ///
  //todo: If context is null?
  static Tween<RelativeRect> _createTween(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    final rect = box.localToGlobal(Offset.zero) & box.size;
    final relativeRect =
        RelativeRect.fromSize(rect, MediaQuery.of(context).size);
    return RelativeRectTween(
      begin: relativeRect,
      end: RelativeRect.fill,
    );
  }
}

/// Passing a Widget builder to the Webpage Controller.
class BuilderPageController extends WebPageController {
  /// Supply a WidgetBuilder instead of a child widget
  /// init and dispose function.
  BuilderPageController({
    required this.inBuilder,
    this.initStateFunc,
    this.disposeFunc,
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
    this.popup,
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

  ///
  final WidgetBuilder inBuilder;

  ///
  final void Function()? initStateFunc;

  ///
  final void Function()? disposeFunc;

  ///
  final bool? popup;

  @override
  void initState() {
    super.initState();

    if (initStateFunc != null) {
      initStateFunc!();
    }
  }

  @override
  void dispose() {
    if (disposeFunc != null) {
      disposeFunc!();
    }
    super.dispose();
  }

  @override
  Widget? builder(BuildContext context) => inBuilder(context);
}
