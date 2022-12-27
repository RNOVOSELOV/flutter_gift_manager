import 'package:flutter/material.dart';

extension ThemeBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeStylesExtension on ThemeData {
  TextStyle get h1 => textTheme.headline1!;

  TextStyle get h2 => textTheme.headline2!;

  TextStyle get h3 => textTheme.headline3!;

  TextStyle get h4 => textTheme.headline4!;

  TextStyle get h5 => textTheme.headline5!;

  TextStyle get h6 => textTheme.headline6!;

  TextStyle get button => textTheme.button!;
}

extension BrightnessDependentTextStyle on TextStyle {
  TextStyle dynamicColor({
    required final BuildContext context,
    required final Color lightThemeColor,
    required final Color darkThemeColor,
  }) {
    final brightness = MediaQuery.of(context).platformBrightness;
    switch (brightness) {
      case Brightness.dark:
        return copyWith(color: darkThemeColor);
      case Brightness.light:
        return copyWith(color: lightThemeColor);
    }
  }
}
