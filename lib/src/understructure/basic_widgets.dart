// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:mvc_web/src/controller.dart';

import 'package:mvc_web/src/view.dart';

/// State Set
// import 'package:state_set/state_set.dart';

/// The base
abstract class BasicScrollStatefulWidget extends StatefulWidget {
  /// Must supply a Webpage controller.
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

/// The base class for the Webpage controller.
abstract class BasicScrollController extends StateXController {
  /// Assign a State object to this class.
  BasicScrollController([State? state])
      : _state = state,
        super(state is StateX ? state : null) {
    // // Add the same State object to all 'Web Page Controllers'
    // final state = StateSet.to<_BasicScrollState>();
    // addState(state);
  }
  State? _state;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    // _scrollController = _BasicScrollController();
    // _scrollController.addListener(() {
    //   // Record the offset with every scroll.
    //   _lastOffset = _offset;
    //   _offset = _scrollController.offset;
    // });
  }

  @override
  void dispose() {
    _state = null;
    scrollController?.dispose();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (_state != null) {
      if (_state!.mounted) {
        //ignore: invalid_use_of_protected_member
        _state!.setState(fn);
      }
    } else {
      super.setState(fn);
    }
    // Notify dependencies of the App's InheritedWidget
    notifyDependencies = true;
  }

  ///
  void refresh() {
    final _inState = state as InheritedStateX;
    // _inState.inheritedStatefulWidget.inheritedChildWidget =
    //     _inState.buildChild(_inState.context);
    _inState.buildWidget(_inState.context);
    super.setState(() {});
  }

  /// Notify the dependencies for the InheritedWidget
  bool notifyDependencies = false;

  ///
  double _offset = 0;

  ///
  double _lastOffset = 0;

  /// Scrolling up
  bool get scrollUp => _offset < _lastOffset;

  /// Scrolling down
  bool get scrollDown => !scrollUp;

  /// The Scroll Controller
  ScrollController? scrollController;

  /// The first ScrollController that takes in a Scrollable
  ScrollController? get rootScrollController =>
      (scrollController as BaseScrollController)._rootScrollController;

  /// Return the offset 'scroll position'
  double get scrollPosition =>
      !scrollController!.hasClients ? 0 : scrollController!.offset;

  ///
  double opacity = 0;

  ///
  Size get screenSize => _screenSize;
  static late Size _screenSize;

  /// Determine if running on a small screen.
  bool get inSmallScreen => _smallScreen;
  static bool _smallScreen = false;

  /// Supply the widget through the controller.
  BasicScrollStatefulWidget? get widget =>
      state?.widget as BasicScrollStatefulWidget;

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

///
class _BasicScrollState
    extends InheritedStateX<BasicScrollStatefulWidget, _BasicInheritedWidget> {
//    with StateSet {
  //
  _BasicScrollState(BasicScrollController _controller)
      : super(
          inheritedBuilder: (child) => _BasicInheritedWidget(
            controller: _controller,
            child: child,
          ),
          controller: _controller,
        ) {
    //
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

    return super.buildWidget(context);
  }

  @override
  Widget buildChild(BuildContext context) => _con.build(context);

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

/// The State object's InheritedWidget
class _BasicInheritedWidget extends InheritedWidget {
  const _BasicInheritedWidget({
    super.key,
    required this.controller,
    required super.child,
  });
  //
  final BasicScrollController controller;

  @override
  bool updateShouldNotify(covariant _BasicInheritedWidget oldWidget) {
    //
    bool notify = controller.notifyDependencies;

    // Always return to false.
    controller.notifyDependencies = false;

    final oldController = oldWidget.controller;

    if (!notify) {
      notify = child != oldWidget.child;
    }

    if (!notify) {
      notify = controller.opacity != oldController.opacity;
    }

    if (!notify) {
      notify = controller.inPortrait != oldController.inPortrait;
    }

    return notify;
  }
}

/// Scroll Controller
class BaseScrollController extends ScrollController {
  ///
  BaseScrollController(this.con) {
    addListener(() {
      // Record the offset with every scroll.
      con._lastOffset = con._offset;
      con._offset = offset;
    });
  }

  ///
  final BasicScrollController con;

  /// The 'first' Scroll Controller
  BaseScrollController? _rootScrollController;

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
