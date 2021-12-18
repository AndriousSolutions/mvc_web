// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/view.dart';

import 'package:url_launcher/url_launcher.dart';

abstract class WebPageBase extends ScaffoldScreenWidget
    with WebPageFeaturesMixin {
  WebPageBase(this.webPageBaseController, {Key? key, String? title})
      : super(webPageBaseController, key: key, title: title);

  final WebPageBaseController webPageBaseController;

  /// The 'child' widget containing the core of the screen's content.
  List<Widget>? child(BuildContext context, [WebPage? widget]) =>
      webPageBaseController.child(context, widget);

  /// Possible Screen overlay
  StackWidgetProperties? screenOverlay(BuildContext context) =>
      webPageBaseController.screenOverlay(context);

  /// Possible bottom bar
  Column? bottomBar(BuildContext context, [WebPage? widget]) =>
      webPageBaseController.bottomBar(context, widget);

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

abstract class WebPageBaseController extends ScaffoldScreenController {
  WebPageBaseController({
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
  }) : super(
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
        );

  /// The axis along which the scroll view scrolls.
  final Axis? scrollDirection;

  /// Whether the scroll view scrolls in the reading direction.
  final bool? reverse;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry? padding;

  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;

  final DragStartBehavior? dragStartBehavior;

  /// Defaults to [Clip.hardEdge].
  final Clip? clipBehavior;

  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;

  //
  /// The 'child' widget containing the core of the screen's content.
  List<Widget>? child(BuildContext context, [WebPage? widget]);

  /// Possible Screen overlay
  StackWidgetProperties? screenOverlay(BuildContext context);

  /// Provide a appBar
  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

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

  /// A bottom bar for every web page.
  Column? bottomBar(BuildContext context, [WebPage? widget]) => null;

  /// This is the 'default' bottom bar if any.
  BottomBar? get appBottomBar => _appBottomBar;
  static BottomBar? _appBottomBar;

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
        context: ErrorDescription('_child = child(context)'),
      ));
      // Make the error known if under development.
      if (App.inDebugger) {
        rethrow;
      }
    }

    Widget? _overlay;

    /// Display the overlay if it exists
    if (_child == null) {
      stackProps = screenOverlay(context);
      _child = stackProps?.child;
    } else {
      stackProps = screenOverlay(context);
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
    //
    WebPage? webPage = widget is WebPage ? widget as WebPage : null;

    List<Widget>? list = child(context, webPage) ?? [];

    // Supply a bottom bar or not?
    if (webPage != null && (webPage.hasBottomBar == null || webPage.hasBottomBar == true)) {
      //
      list.add(SizedBox(height: screenSize.height / 10));

      Column? bottomColumn = webPage.bottomBar(context, webPage);

      bottomColumn ??= bottomBar(context, webPage);

      BottomBar? _bottomBar;
      // Was a bottom bar column generated?
      if (bottomColumn != null) {
        //
        _bottomBar = BottomBar(children: bottomColumn);

        // Save the bottom bar for future use.
        _appBottomBar ??= _bottomBar;
      } else if (_appBottomBar != null) {
        //
        _bottomBar = _appBottomBar!;
      }

      if (_bottomBar != null) {
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
    String? coverImage,
    bool? coverBanner,
    bool? accessBar,
    bool? bottomBar,
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
              coverImage: coverImage,
              coverBanner: coverBanner,
              accessBar: accessBar,
              bottomBar: bottomBar,
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

// class _WebPageBaseController extends WebPageBaseController {
//   _WebPageBaseController([StateMVC? state]) : super(state: state);
//
//   @override
//   PreferredSizeWidget? appBar(BuildContext context) => null;
//
//   /// Possibly overlay displayed on top of the screen.
//   @override
//   StackWidgetProperties? screenOverlay(
//     BuildContext context, {
//     AlignmentGeometry? alignment,
//     TextDirection? textDirection,
//     StackFit? fit,
//     Clip? clipBehavior,
//   }) =>
//       null;
//
//   /// Possibly the main content on the screen.
//   @override
//   Widget? child(BuildContext context) => null;
// }

/// Containing standard functionality for a typical webpage.
mixin WebPageFeaturesMixin {
  //
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

class FractionallySizedWidget extends StatelessWidget {
  const FractionallySizedWidget({
    Key? key,
    required this.widthFactor,
    required this.child,
  }) : super(key: key);
  final double widthFactor;
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

class StackWidgetProperties {
  StackWidgetProperties({
    this.alignment,
    this.textDirection,
    this.fit,
    this.clipBehavior,
    required this.child,
  });
  final AlignmentGeometry? alignment;
  final TextDirection? textDirection;
  final StackFit? fit;
  final Clip? clipBehavior;
  final Widget? child;
}
