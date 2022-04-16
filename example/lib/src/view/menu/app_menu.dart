// Copyright 2021 Andrious Solutions Ltd. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:example/src/controller.dart';

import 'package:mvc_application/view.dart';

/// Supply the app's popupmenu
Widget popupMenu({
  Key? key,
  List<String>? items,
  PopupMenuItemBuilder<String>? itemBuilder,
  String? initialValue,
  PopupMenuItemSelected<String>? onSelected,
  PopupMenuCanceled? onCanceled,
  String? tooltip,
  double? elevation,
  EdgeInsetsGeometry? padding,
  Widget? child,
  Widget? icon,
  Offset? offset,
  bool? enabled,
  ShapeBorder? shape,
  Color? color,
  bool? captureInheritedThemes,
}) =>
    PopMenu(
      key: key,
      items: items,
      itemBuilder: itemBuilder,
      initialValue: initialValue,
      onSelected: onSelected,
      onCanceled: onCanceled,
      tooltip: tooltip,
      elevation: elevation,
      padding: padding,
      child: child,
      icon: icon,
      offset: offset,
      enabled: enabled,
      shape: shape,
      color: color,
      captureInheritedThemes: captureInheritedThemes,
    ).popupMenuButton;

class PopMenu extends AppPopupMenu<String> {
  //
  PopMenu({
    Key? key,
    List<String>? items,
    PopupMenuItemBuilder<String>? itemBuilder,
    String? initialValue,
    PopupMenuItemSelected<String>? onSelected,
    PopupMenuCanceled? onCanceled,
    String? tooltip,
    double? elevation,
    EdgeInsetsGeometry? padding,
    Widget? child,
    Widget? icon,
    Offset? offset,
    bool? enabled,
    ShapeBorder? shape,
    Color? color,
    bool? captureInheritedThemes,
  }) : super(
          key: key ?? const Key('appMenuButton'),
          items: items,
          itemBuilder: itemBuilder,
          initialValue: initialValue,
          onSelected: onSelected,
          onCanceled: onCanceled,
          tooltip: tooltip,
          elevation: elevation,
          padding: padding,
          child: child,
          icon: icon,
          offset: offset ?? const Offset(0, 45),
          enabled: enabled,
          shape: shape ??
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: color,
          // false so to prevent the error,
          // "Looking up a deactivated widget's ancestor is unsafe."
          captureInheritedThemes: captureInheritedThemes ?? false,
        );

  @override
  List<PopupMenuItem<String>> get menuItems => [
        PopupMenuItem(
          key: const Key('localeMenuItem'),
          value: 'locale',
          child: Text('${L10n.s('Locale:')} ${App.locale!.toLanguageTag()}'),
        ),
        PopupMenuItem(
          key: const Key('aboutMenuItem'),
          value: 'about',
          child: Text('About'.tr),
        ),
      ];

  @override
  Future<void> onSelection(String value) async {
    final appContext = App.context!;
    switch (value) {
      case 'locale':
        final locales = AppTrs.supportedLocales;

        final initialItem = locales.indexOf(App.locale!);

        final spinner = ISOSpinner(
            initialItem: initialItem,
            supportedLocales: locales,
            onSelectedItemChanged: (int index) async {
              // Retrieve the available locales.
              final locale = AppTrs.getLocale(index);
              if (locale != null) {
                // You must 'rebuild' the whole App all over again.
                App.locale = locale;
                App.refresh();
              }
            });

        await DialogBox(
          title: 'Current Language'.tr,
          body: [spinner],
          press01: () {
            spinner.onSelectedItemChanged(initialItem);
          },
          press02: () {},
        ).show();

        break;
      case 'about':
        showAboutDialog(
          context: appContext,
          applicationName: App.vw?.title ?? '',
          applicationVersion:
              'version: ${App.version} build: ${App.buildNumber}',
        );
        break;
      default:
    }
  }
}
