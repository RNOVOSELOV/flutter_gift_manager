import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/presentation/gifts/bloc/gifts_bloc.dart';

class GiftsPage extends StatelessWidget {
  const GiftsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<GiftsBloc>()..add(const GiftsPageLoaded()),
      child: const _GiftsPageWidget(),
    );
  }
}

class _GiftsPageWidget extends StatelessWidget {
  const _GiftsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GiftsBloc, GiftsState>(
        builder: (context, state) {
          if (state is InitialGiftsLoadingState) {
            // SHOW LOADING STATE
          } else if (state is NoGiftsState) {
            // SHOW NO GIFTS STATE
          } else if (state is InitialLoadingErrorState) {
            // SHOW LOADING ERROR
          } else if (state is LoadedGiftsState) {
            // SHOW GIFTS
          }
          debugPrint("Unknown state: $state");
          // SHOW LOADING ERROR
          return const Center(child: Text("Gifts unrekognized state",));
        },
      ),
    );
  }
}
