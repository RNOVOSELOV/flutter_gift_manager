import 'package:flutter/material.dart';
import 'package:gift_manager/navigation/route_name.dart';
import 'package:gift_manager/presentation/gift/gift_page.dart';
import 'package:gift_manager/presentation/gifts/view/gifts_page.dart';
import 'package:gift_manager/presentation/home/view/home_page.dart';
import 'package:gift_manager/presentation/login/view/login_page.dart';
import 'package:gift_manager/presentation/registration/view/registration_page.dart';
import 'package:gift_manager/presentation/reset_password/view/reset_password_page.dart';
import 'package:gift_manager/presentation/splash/view/splash_page.dart';

RouteFactory generateRoute() {
  return (setting) {
    final name = setting.name;
    if (name == null || name.isEmpty) {
      return MaterialPageRoute(builder: (_) => const SplashPage());
    }
    final routeName = RouteName.find(name);
    if (routeName == null) {
      return MaterialPageRoute(builder: (_) => const SplashPage());
    }
    switch (routeName) {
      case RouteName.splash:
        return _createPageRoute(const SplashPage(), routeName);
      case RouteName.gifts:
        return _createPageRoute(const GiftsPage(), routeName);
      case RouteName.home:
        return _createPageRoute(const HomePage(), routeName);
      case RouteName.login:
        return _createPageRoute(const LoginPage(), routeName);
      case RouteName.registration:
        return _createPageRoute(const RegistrationPage(), routeName);
      case RouteName.resetPassword:
        return _createPageRoute(const ResetPasswordPage(), routeName);
      case RouteName.gift:
        final args = (setting.arguments is GiftPageArgs)
            ? (setting.arguments as GiftPageArgs)
            : null;
        if (args == null) {
          debugPrint(
              "Gift page arguments error. Received arguments: ${setting.arguments.toString()}");
        }
        return _createPageRoute(
            GiftPage(args: args ?? const GiftPageArgs(giftName: 'unknown')),
            routeName);
    }
  };
}

Route _createPageRoute(Widget page, RouteName routeName) {
  return MaterialPageRoute(
    builder: (_) => page,
    settings: RouteSettings(name: routeName.name),
  );
}
