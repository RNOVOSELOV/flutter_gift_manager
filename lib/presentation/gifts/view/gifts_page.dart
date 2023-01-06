import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gift_manager/data/http/model/gift_dto.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/presentation/gifts/bloc/gifts_bloc.dart';
import 'package:gift_manager/resources/AppIllustrations.dart';
import 'package:gift_manager/resources/app_colors.dart';

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
            return const _LoadingWidget();
          } else if (state is NoGiftsState) {
            // SHOW NO GIFTS STATE
            return const _NoGiftsWidget();
          } else if (state is InitialLoadingErrorState) {
            // SHOW LOADING ERROR
            return const _InitialLoadingErrorWidget();
          } else if (state is LoadedGiftsState) {
            // SHOW GIFTS
            return _GiftsListWidget(
              gifts: state.gifts,
              showError: state.showError,
              showLoading: state.showLoading,
            );
          }
          debugPrint("Unknown state: $state");
          // SHOW LOADING ERROR
          return const Center(
              child: Text(
            "Gifts page: unrecognized state",
          ));
        },
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _NoGiftsWidget extends StatelessWidget {
  const _NoGiftsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        SvgPicture.asset(AppIllustrations.noGifts),
        const SizedBox(
          height: 37,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Добавьте свой первый подарок',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _InitialLoadingErrorWidget extends StatelessWidget {
  const _InitialLoadingErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        SvgPicture.asset(AppIllustrations.noGifts),
        const SizedBox(
          height: 37,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Произошла ошибка',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: ElevatedButton(
            onPressed: () =>
                context.read<GiftsBloc>().add(const GiftsLoadingRequest()),
            child: Text('Попробовать снова'.toUpperCase()),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _GiftsListWidget extends StatelessWidget {
  const _GiftsListWidget({
    Key? key,
    required this.gifts,
    required this.showLoading,
    required this.showError,
  }) : super(key: key);

  final List<GiftDto> gifts;
  final bool showLoading;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      separatorBuilder: (_, __) => const SizedBox(
        height: 12,
      ),
      itemCount: gifts.length + 1 + (_haveExtraBottomWidget ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Text(
            'Подарки:',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          );
        }
        // Обработка ниженего элемента (отображение загрузки или ошибки в посленем элементе лист вью)
        if (index == gifts.length + 1) {
          if (showLoading) {
            return Container(
              height: 56,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          } else {
            if (!showError) {
              debugPrint(
                  'index == gifts.length + 1 but showLoading = false and showError = false');
            }
            return Container(
              height: 56,
              alignment: Alignment.center,
              child: Text('ERROR'),
            );
          }
        }

        final gift = gifts[index - 1];
        return Container(
          height: 88,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFF0F2F7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                gift.name,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'GIFT ITEM',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 20 / 16,
                  color: AppColors.lightGrey100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool get _haveExtraBottomWidget => showLoading || showError;
}
