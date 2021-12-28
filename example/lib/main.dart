// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/controller.dart';

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
  }) : super(
          controller: CounterAppController(),
          key: key,
        );
}
