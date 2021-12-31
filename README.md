# MVC Web
![Flutter WWW](https://user-images.githubusercontent.com/32497443/147765368-d6a71ae6-ba4d-4275-8337-0d9d8879c113.png)

[![Medium](https://img.shields.io/badge/Medium-Read-green?logo=Medium)](https://medium.com/p/f612461dc037/)
[![Last Commit](https://img.shields.io/github/last-commit/AndriousSolutions/mvc_pattern)](https://github.com/AndriousSolutions/mvc_web/commits/master)
Supplies a custom framework used for more comprehensive and more interactive Web app.

## What ist it?
This is a custom framework that works like Flutter following an established design pattern and merely brings together all the widgets that makeup Flutter and runs the appropriate ones depending on the parameter values you supply.

It's a framework I use for all my mobile apps, and now, for all my apps on the Web. Let's introduce it to you using the good ol' counter app you're presented with every time you create a new Flutter project. However, this one will be running on a browser with one additional feature:
![counter app](https://i.imgur.com/xK9h6h6.gif)

## An App Like Any Other
You can see the counter app example above works with a little Localization as well. Not only can it sense where it is running in the World and use the appropriate localized language---you can change the language with a tap! Thanks to this package called, mvc_web. This example's code accompanies this package, and can be found in this [repository](https://github.com/AndriousSolutions/mvc_web/tree/master/example).

Further, like any app, a Web app needs to get set up properly before a user can use it. The screenshot below is the main.dart file for the example app. You can see the general theme of the app is set up here. Further, the form of navigation to be used when going from web page to webpage is established here as well as its Localization capabilities. Even the debug flags used during development can be set here in the AppState class constructor displayed below. The AppMVC class is a StatefulWidget, and the AppState class is its  State object. Pretty straightforward.

![main.dart](https://user-images.githubusercontent.com/32497443/147723895-85603ed6-2be2-451a-873a-8918df970bb0.png)

You'll find the AppState constructor supplies the developer with a full array of parameter options. All to instruct how the app is to look and behave. If you've gotten to know Flutter, you'll readily recognize the many parameters available to you in the AppState class. It's all to make life a little easier for the humble developer. See below.

You simply have to use the ones you want, and like any good framework, those chosen parameters are then implemented accordingly. Again, this framework works for your mobile apps, but today, we're looking into its Web capabilities.

![app_state](https://user-images.githubusercontent.com/32497443/147724194-1afbe5f6-5ad9-433e-8b23-193bcb6b352e.png)

Back to the example app, the next two screenshots below focus on the 'home' page---the main webpage for the example app. In the second screenshot, you're introduced to the framework's 'Web Page' widget. It too has its many parameters, but our attention right now is on its controller, CounterAppController. That's where the magic happens in most instances. The 'Web Page' widget extends Flutter's StatefulWidget, and as such it's kept light in code content. As you know, it's traditionally the StatefulWidget's State object and consequently, in this case, the aforementioned Controller that contains the majority of code for a typical Flutter app.

![MyApp](https://user-images.githubusercontent.com/32497443/147724296-e7c97c9b-a8a5-4b67-a0f7-9e1268425062.png)
![MyHomePage](https://user-images.githubusercontent.com/32497443/147724357-a3ffa3a4-11c4-4cfc-a42c-129c22f104ba.png)

The class, _CounterAppController_, extends the class, WebPageController. It too, as part of the framework, carries a long list of parameter options. See below. On closer inspection, you'll recognize these parameters are traditionally more associated with a Scaffold widget. Again, a custom framework should give ready access to the capabilities of its underlying platform or framework - Flutter in this case.

![WebPageController](https://user-images.githubusercontent.com/32497443/147724444-7f6e7c4c-4919-4a41-acc1-95fac5054fd2.png)

Now, as you'll see, this particular part of the framework is designed to work with Web apps. And so, further along in the WebPageController class, you have the means to do just that. This is an abstract class, and so to get your Web app up and running, the builder() function is to be implemented. Further along, there are even more functions for your web page. You gotta love options, right? You'll recognize some of the function names listed and so will deduce what they pertain to.

![1_dhH7VuGFdUa-AVNdi5ZyiQ](https://user-images.githubusercontent.com/32497443/147724509-51916f19-9dca-4071-8e76-da38a14aa95e.png)

Deeper in this framework, you'll find the anticipated Scaffold widget taking in the many parameter options and supplying default values when none are provided. All so you can build an interactive and comprehensive Web app in Flutter. Gotta love it.

![scaffold](https://user-images.githubusercontent.com/32497443/147724556-272d643b-e013-4266-b322-fa4a5065a705.png)

Again, back to our example app. At first glance, you'll note the ever-important Controller class is using a factory constructor and thus implementing the Singleton design pattern. I find the role of a Controller is best served with a single instance of that class throughout the life of the app. That's because it's called upon to respond to various system and user events throughout the course of its lifecycle and yet is to retain an ongoing and reliable state. A factory constructor readily accomplishes this.
Next, note in the screenshot below, an Appbar is defined in the convenient onAppBar() function. However, being such a simple Appbar, it could have just as well been supplied as a parameter to the Controller's constructor. That's demonstrated in the second screenshot below. Gotta love options.

![CounterAppController](https://user-images.githubusercontent.com/32497443/147724679-c820bfb1-7224-48cf-8980-d6bf28cf7a73.png)
![CounterAppController](https://user-images.githubusercontent.com/32497443/147724732-069cf37b-acdf-43c5-9a74-cbca463710b3.png)

Looking back at the Scaffold widget deep in the framework, it's the AppBar supplied by the parameter that takes precedence. Are you seeing the advantages of using a custom framework yet? Again, you just supply the appropriate parameter values, and the framework worries about the rest. There's no 're-inventing the Wheel' here. It's still using Flutter. It's just worrying about 'how' Flutter is being used for you.

![scaffold](https://user-images.githubusercontent.com/32497443/147724787-42e0455c-9a73-45c3-8aba-245a043af6fd.png)

And now to the crux of the matter. Inside your Web app's controller, the builder() function is to return a Widget representing a particular web page. It is the equivalent to the build() function in a typical StatefulWidget's State object but this function is privy to a number of operators and to functionality necessary in implementing a web page. You'll note, however, in the screenshot below, you've still access to the same setState() function used in a typical build() function. And so, tapping on the FloatingActionButton will increment that counter as expected. But this time, it's running on a browser.

![builder](https://user-images.githubusercontent.com/32497443/147724846-5c20cef7-711d-4c23-88b7-9fd14d5c3d6a.png)

Now, an alternate approach would be to have the 'interface' (the View) supplied by a separate class in a separate library file altogether. The example app has this also implemented for demonstration purposes in a separate Dart file called, counter_app_view.dart. The previous builder() function is commented out below to make way for this separate class.

Now which approach you use will depend on how 'modular' you wish an app's components to be with high cohesion and low coupling a common desire. In still other instances, it may come down to personal preference - like how one pronounces that fruit many consider a vegetable: "Tomatoes (/təˈmeɪtoʊz/); Tomatoes (/təˈmɑːtoʊz/)."

![builder](https://user-images.githubusercontent.com/32497443/147724932-e4719e5f-d67a-4802-b090-2272c630504d.png)

The CounterApp class now called above is that of typical StatefulWidget. However, the custom framework supplies it with a special State object of the class, StateMVC, so a WebPageController object can then call that State object's setState() function when necessary. In this case, when an incremented counter is to be displayed on the screen. In the screenshot below, the setState() function is called in the Controller: `con.onpressed()`

In fact, the Controller has access to the State object itself and its other capabilities, but that's for another time. Know now that, since the Controller has a factory constructor, you're only instantiating one instance of this class, that then has access to the appropriate State object you're  currently working with: `con = CounterAppController(this)`.

![counterApp](https://user-images.githubusercontent.com/32497443/147725007-08c4082e-0a11-4ee1-a2f7-47b21a06f3b5.png)

A screenshot of that Controller, reveals the setState() function being called in its onPressed() function. Note, there's a separate class being instantiated into a variable called, model, that's responsible for the 'data source' used by this app. Making such separations may be impractical for such a simple app, but is highly recommended as your Flutter apps get more complicated. Clarifying that statement is also for another time, but you likely know what I mean.

![controller](https://user-images.githubusercontent.com/32497443/147725069-7b6018f7-df15-47e7-bde3-71e626ef0335.png)

Possibly, you're still new to Flutter and may be more comfortable with the traditional approach of calling the setState() function right inside the FloatingActionButton widget. That's easily accomplished as well. See below.

![floatingActionButton](https://user-images.githubusercontent.com/32497443/147725129-bd384461-c6a9-4208-8be7-5080b3008acd.png)

Again, these additional capabilities when working with the custom framework's State object will allow your app a little more modular.

![mvc_graphic](https://user-images.githubusercontent.com/32497443/147725203-97f23d6c-903d-4bdf-9206-ac8159d60691.jpeg)

## What's Your Size?
Screen size is important for Flutter Web, and so, the custom framework gives you ready access to the screen size being used when running your app. It's important to know the screen size at any given moment so as to 'draw' the interface accordingly. Things may have to be redrawn, for example, when a mobile phone switches from portrait to landscape.

![builder](https://user-images.githubusercontent.com/32497443/147725299-6510d4cf-8867-49f1-a596-157c678e5a94.png)

## Usage

Below is the main.dart file for the example app as well as the main Controller involved.
The full code is found in the package's `/example` folder.

```dart
import 'package:mvc_web/mvc_web.dart';

import 'package:example/src/controller.dart';

void main() => runApp(MyApp());

class MyApp extends AppMVC {
  MyApp({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState(
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        // This is the app's navigation
        routerDelegate: AppRouterDelegate(routes: {
          '/': (_) => MyHomePage(),
        }),
        // This is the app's localization
        supportedLocales: I10n.supportedLocales,
        localizationsDelegates: [
          I10nDelegate(),
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
    Key? key,
  }) : super(
          controller: CounterAppController(),
          key: key,
        );
}
```
```dart
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
```