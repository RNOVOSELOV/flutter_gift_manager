import 'package:collection/collection.dart';

enum RouteName {
  // "/" - изначальный route, переход на короый идет по умолчанию при старте приложения
  splash(route: "/"),
  gifts(route: "/gifts"),
  home(route: "/home"),
  login(route: "/login"),
  registration(route: "/registration"),
  resetPassword(route: "/reset_password"),
  ;

  static RouteName? find(String? name) =>
      values.firstWhereOrNull((routeName) => routeName.route == name);

  final String route;

  const RouteName({required this.route});
}