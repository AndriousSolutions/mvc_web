// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/controller.dart';

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  State createState() => _CounterAppState();
}

class _CounterAppState extends StateMVC<CounterApp> {
  @override
  void initState() {
    super.initState();
    con = CounterAppController(this);
  }

  late CounterAppController con;

  @override
  Widget build(BuildContext context) {
    final _smallScreen = con.inSmallScreen;
    final _screenSize = con.screenSize;
    final _landscape = con.inLandscape;
    return Column(children: <Widget>[
      SizedBox(height: _screenSize.height * 0.3),
      I10n.t('You have pushed the button this many times:'),
      SizedBox(height: _screenSize.height * 0.05),
      Text(
        '${con.counter}',
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
//          onPressed: con.onPressed,
          onPressed: () => setState(() {
            con.incrementCounter();
          }),
          child: const Icon(Icons.add),
        ),
      ),
    ]);
  }
}
