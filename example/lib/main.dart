// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/view.dart';

void main() => runApp(MyApp());

class MyApp extends AppMVC {
  MyApp({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        routerDelegate: AppRouterDelegate(routes: {
          '/': (_) => MyHomePage(),
        }),
        supportedLocales: I10n.supportedLocales,
        localizationsDelegates: [
          I10nDelegate(),
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
//    debugPaintSizeEnabled: true,
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends WebPageWidget {
  MyHomePage({
    Key? key,
  }) : super(controller: Controller(), key: key);
}

/// The Controller can provide the content.
class Controller extends WebPageController {
  factory Controller() => _this ??= Controller._();

  Controller._()
      : model = _Model(),
        super(
          appBar: AppBar(
            title: const Text('Flutter Demo Home Page'),
            actions: [
              popupMenu(),
            ],
          ),
        );

  static Controller? _this;
  final _Model model;

  late InheritedStateWidget updater;

  /// Main content
  @override
  List<Widget>? withHeader04(BuildContext context, [WebPageWidget? widget]) {
    final _smallScreen = inSmallScreen;
    final _screenSize = screenSize;
    final _landscape = inLandscape;
    return <Widget>[
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
          /// Try this alternative approach.
          /// The Controller merely mimics the Flutter's API
//          onPressed: onPressed,
          onPressed: () => setState(_incrementCounter),
          child: const Icon(Icons.add),
        ),
      ),
    ];
  }

  /// You're free to mimic Flutter's own API
  /// The Controller is able to talk to the View (the State object)
  void onPressed() => setState(() => model._incrementCounter());

  int get counter => model.integer;

  /// The Controller knows how to 'talk to' the Model.
  void _incrementCounter() => model._incrementCounter();

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
//    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
}

class _Model {
  int get integer => _integer;
  int _integer = 0;
  int _incrementCounter() => ++_integer;
}
