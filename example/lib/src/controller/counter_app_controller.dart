// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/model.dart';

import 'package:example/src/view.dart';

/// The Controller determines the content provided.
class CounterAppController extends WebPageController {
  factory CounterAppController([StateMVC? state]) {
    _this ??= CounterAppController._();
    _this?.addState(state);
    return _this!;
  }
  CounterAppController._()
      : model = CounterAppModel(),
        super(
          appBar: AppBar(
            title: I10n.t('Flutter Demo Home Page'),
            actions: [
              popupMenu(),
            ],
          ),
        );

  static CounterAppController? _this;
  final CounterAppModel model;

  @override
  PreferredSizeWidget? onAppBar() => AppBar(
        title: I10n.t('Flutter Demo Home Page'),
        actions: [
          popupMenu(),
        ],
      );

  /// An example of implementing a separate interface.
  // @override
  // Widget builder(context) => const CounterApp();

  @override
  Widget builder(BuildContext context) {
    final _smallScreen = inSmallScreen;
    final _screenSize = screenSize;
    final _landscape = inLandscape;
    return Column(children: <Widget>[
      SizedBox(height: _screenSize.height * 0.3),
      I10n.t('You have pushed the button this many times:'),
      SizedBox(height: _screenSize.height * 0.05),
      Text(
        '$counter',
        style: Theme.of(context).textTheme.headline4,
      ),
      Container(
        alignment: Alignment.centerRight,
        height: _screenSize.height * 0.1,
        margin: EdgeInsets.fromLTRB(
          _screenSize.width * (_smallScreen ? 0.05 : 0.5),
          _screenSize.height * (_smallScreen ? 0.05 : 0.3),
          _screenSize.width * (_smallScreen ? (_landscape ? 0.05 : 0.05) : 0.3),
          _screenSize.height *
              (_smallScreen ? (_landscape ? 0.05 : 0.05) : 0.05),
        ),
        child: FloatingActionButton(
//          onPressed: onPressed,
          onPressed: () => setState(() {
            incrementCounter();
          }),
          child: const Icon(Icons.add),
        ),
      ),
    ]);
  }

  /// You're free to mimic Flutter's own API
  /// The Controller is able to talk to the View (the State object)
  /// and call the setState() function.
  void onPressed() => setState(() => model.incrementCounter());

  void incrementCounter() => model.incrementCounter();

  int get counter => model.integer;

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
//    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
}
