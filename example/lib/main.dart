// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/controller.dart';

void main() => runApp(MyApp());

class MyApp extends AppStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  AppState createAppState() => AppState(
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        // This is the app's navigation
        routerDelegate: AppRouterDelegate(routes: {
          '/': (_) => MyHomePage(),
        }),
        // This is the app's localization
        supportedLocales: AppTrs.supportedLocales,
        localizationsDelegates: [
          L10n.delegate!,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        // These are flags used during development
//    debugPaintSizeEnabled: true,
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends WebPageWidget {
  MyHomePage({
    GlobalKey? key,
  }) : super(
          controller: CounterAppController(),
          key: key ?? GlobalKey(debugLabel: 'mvc_web_example'),
        );
}
