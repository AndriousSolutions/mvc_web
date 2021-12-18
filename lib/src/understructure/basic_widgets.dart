// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/src/controller.dart';

import 'package:mvc_web/src/view.dart';

/// The base
abstract class BasicScrollStatefulWidget extends StatefulWidget {
  const BasicScrollStatefulWidget(this._controller, {Key? key})
      : super(key: key);

  final BasicScrollController _controller;

  /// Determine the current screen size.
  Size? get screenSize => _controller.screenSize;

  /// The State object's Scroll Controller
  ScrollController? get scrollController => _controller.scrollController;

  /// The State object's Scroll Position
  double get scrollPosition => _controller.scrollPosition;

  /// The State object's current opacity.
  double get opacity => _controller.opacity;

  @override
  //ignore: no_logic_in_create_state
  State createState() => _BasicScrollState(_controller);
}

abstract class BasicScrollController extends ControllerMVC {
  BasicScrollController([StateMVC? state]) : super(state);

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _scrollController = _BasicScrollController();
    _scrollController.addListener(() {
      // Record the offset with every scroll.
      _lastOffset = _offset;
      _offset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  late ScrollController _scrollController;

  double _offset = 0;
  double _lastOffset = 0;

  /// Scrolling up
  bool get scrollUp => _offset < _lastOffset;

  /// Scrolling down
  bool get scrollDown => !scrollUp;

  /// The Scroll Controller
  ScrollController get scrollController => _scrollController;

  /// The first ScrollController that takes in a Scrollable
  ScrollController? get rootScrollController =>
      (_scrollController as _BasicScrollController)._rootScrollController;

  /// Return the offset 'scroll position'
  double get scrollPosition =>
      !_scrollController.hasClients ? 0 : _scrollController.offset;

  double opacity = 0;

  Size get screenSize => _screenSize;
  static late Size _screenSize;

  /// Determine if running on a small screen.
  bool get inSmallScreen => _smallScreen;
  static bool _smallScreen = false;

  /// Supply the widget through the controller.
  BasicScrollStatefulWidget get widget =>
      state!.widget as BasicScrollStatefulWidget;

  /// Is the phone orientated in Portrait
  bool get inPortrait => _orientation == Orientation.portrait;

  /// Is the phone orientated in Landscape
  bool get inLandscape => _orientation == Orientation.landscape;

  /// Determine the phone's orientation
  Orientation orientation(BuildContext context) =>
      _orientation = MediaQuery.of(context).orientation;
  static Orientation? _orientation;

  /// Find the latest BasicScrollStatefulWidget object if any
  static T? of<T extends BasicScrollStatefulWidget>(BuildContext? context) {
    assert(context != null);
    return context?.findAncestorWidgetOfExactType<T>();
  }

  /// You must implement the build() function.
  Widget build(BuildContext context);
}

class _BasicScrollState extends StateMVC<BasicScrollStatefulWidget>
    with StateSet {
  _BasicScrollState(BasicScrollController _controller) : super(_controller) {
    _con = controller as BasicScrollController;
  }
  //
  late BasicScrollController _con;

  @override
  Widget build(BuildContext context) {
    //
    _con.orientation(context);

    BasicScrollController._screenSize = MediaQuery.of(context).size;

    /// Determine if the app is running in a small screen.
    BasicScrollController._smallScreen =
        _isSmallScreen(screenSize: BasicScrollController._screenSize);

    _con.opacity =
        _con._offset < BasicScrollController._screenSize.height * 0.40
            ? _con._offset / (BasicScrollController._screenSize.height * 0.40)
            : 1;

    return _con.build(context);
  }

  /// Determine if the app is running on a 'small screen' or not.
  bool _isSmallScreen({Size? screenSize}) {
    //
    bool smallScreen;

    // May be manually assigned.
    smallScreen = asSmallScreen;

    if (!smallScreen && screenSize != null) {
      smallScreen = screenSize.width < 800;
    }

    _inSmallScreen = smallScreen;

    return smallScreen;
  }

  /// Set whether the app is to use a 'small screen' or not.
  /// Determine if running on a desktop or on a phone or tablet
  bool get asSmallScreen => App.inDebugger && false;

  /// Return the bool value indicating if running in a small screen or not.
  bool get inSmallScreen => _inSmallScreen;
  bool _inSmallScreen = false;
}

class _BasicScrollController extends ScrollController {
  /// Creates a controller for a scrollable widget.
  ///
  _BasicScrollController({
    double initialScrollOffset = 0.0,
    bool keepScrollOffset = true,
    String? debugLabel,
  }) : super(
          initialScrollOffset: initialScrollOffset,
          keepScrollOffset: keepScrollOffset,
          debugLabel: debugLabel,
        );

  /// The 'first' Scroll Controller
  _BasicScrollController? _rootScrollController;

  @override
  ScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    // Record the 'root' Scroll Controller
    _rootScrollController ??= this;

    return super.createScrollPosition(
      physics,
      context,
      oldPosition,
    );
  }
}
