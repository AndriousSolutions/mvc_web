
## 1.9.0
June 24, 2025
- Backup source code

## 1.8.0
 November 19, 2022
- Introduced fluttery_framework package
- import 'package:state_set/state_set.dart'; only where needed.

## 1.7.0+01
 April 16, 2022
- // Notify dependencies of the App's InheritedWidget
- notifyDependencies = true;
- /// The State object's InheritedWidget
- class _BasicInheritedWidget extends InheritedWidget {
- /// Present the Scaffold widget to its own State object.
- class _ScaffoldBuilder extends StatefulWidget {
- sdk: ">=2.16.2 <3.0.0"
- BottomBarColumn now has optional column entries

## 1.6.1
 March 31, 2022
- StatefulWidgets insist on Key and not GlobalKey unfortunately.

## 1.6.0
 March 31, 2022
- // Got to be a Global Key. Don't want the State object to be rebuilt.
- mvc_application 8.0.0

## 1.5.0
 March 27, 2022
- L10n_translator.dart
- mvc_application 8.9.0

## 1.4.0
 December 30, 2021
- Map<String, String> params() {   String urlPath() {

## 1.3.0+02
 December 29, 2021
- _this?.addState(state);
- class _CounterAppState extends StateMVC<CounterApp> {
- Corrected README.md

## 1.3.0
 December 28, 2021
- final state = StateSet.to<_BasicScrollState>();
- child: const BackButton(),
- WebPageWidget? get widget {
- PreferredSizeWidget? onAppBar() => super.onAppBar();
- Widget builder(BuildContext context) {
- List<Widget> buildList(BuildContext context) {

## 1.2.0
 December 21, 2021
- Example app
- class WebPage to class WebPageWidget
- PreferredSizeWidget? appBar, in WebPageController
- PreferredSizeWidget? onAppBar() =>
- final bool? primary;

## 1.1.0
 December 17, 2021
- utils/hyperlink.dart';
- utils/iframe_widget.dart';
- utils/web_utils.dart';

## 1.0.0
 December 14, 2021
- initial commit and release

