// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/controller.dart';

import 'package:example/src/model.dart' show deDE, esAR, frFR, heIL, ruRU, zhCN;

void main() => runApp(MyApp());

class MyApp extends AppStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  AppState createAppState() => AppState(
        inInitState: () {
          /// The app's translations
          L10n.translations = {
            const Locale('zh', 'CN'): zhCN,
            const Locale('fr', 'FR'): frFR,
            const Locale('de', 'DE'): deDE,
            const Locale('he', 'IL'): heIL,
            const Locale('ru', 'RU'): ruRU,
            const Locale('es', 'AR'): esAR,
          };
        },
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        // This is the app's navigation
        routerDelegate: AppRouterDelegate(routes: {
          '/': (_) => MyHomePage(),
        }),
        // This is the app's localization
        supportedLocales: L10n.supportedLocales,
        localizationsDelegates: [
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          L10n.delegate,
        ],
        // These are flags used during development
//    debugPaintSizeEnabled: true,
        debugShowCheckedModeBanner: false,
      );
}

class MyHomePage extends WebPageWidget {
  MyHomePage({
    Key? key,
  }) : super(
          controller: CounterAppController(),
          key: key ?? GlobalKey(debugLabel: 'mvc_web_example'),
        );
}
