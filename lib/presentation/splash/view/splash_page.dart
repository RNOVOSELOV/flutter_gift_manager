import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/navigation/route_name.dart';
import 'package:gift_manager/presentation/splash/bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = sl.get<SplashBloc>();
    _bloc.add(const SplashLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: const _SplashWidget(),
    );
  }
}

class _SplashWidget extends StatelessWidget {
  const _SplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashUnauthorized) {
          Navigator.of(context).pushReplacementNamed(RouteName.login.route);
        } else if (state is SplashAuthorized) {
          Navigator.of(context).pushReplacementNamed(
            RouteName.home.route,
          );
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
