import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/navigation/route_generator.dart';
import 'package:gift_manager/presentation/splash/view/splash_page.dart';
import 'package:gift_manager/presentation/theme/theme.dart';
import 'package:gift_manager/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Manager',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: generateRoute(),
    );
  }
}
