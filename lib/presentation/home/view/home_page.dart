import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/presentation/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<HomeBloc>()..add(const HomePageLoaded()),
      child: const _HomePageWidget(),
    );
  }
}

class _HomePageWidget extends StatelessWidget {
  const _HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeWithUser) {
                  return Text(
                    state.user.toString(),
                    textAlign: TextAlign.center,
                  );
                }
                return const Text("Home page");
              },
            ),
            const SizedBox(
              height: 42,
            ),
            TextButton(
              onPressed: () async {
                context.read<HomeBloc>().add(const HomeLogoutPushed());
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
