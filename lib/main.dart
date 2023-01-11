import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/navigation/route_generator.dart';
import 'package:gift_manager/presentation/theme/custom_theme.dart';
import 'package:gift_manager/presentation/theme/theme.dart';
import 'package:gift_manager/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    sl.get<CustomTheme>().addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Manager',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: sl.get<CustomTheme>().currentTheme,
      onGenerateRoute: generateRoute(),
    );
  }
}
