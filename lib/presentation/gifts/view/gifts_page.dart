import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gift_manager/data/http/model/gift_dto.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/extentions/theme_extensions.dart';
import 'package:gift_manager/navigation/route_name.dart';
import 'package:gift_manager/presentation/gift/view/gift_page.dart';
import 'package:gift_manager/presentation/gifts/bloc/gifts_bloc.dart';
import 'package:gift_manager/resources/app_colors.dart';
import 'package:gift_manager/resources/app_illustrations.dart';

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

class _GiftsListWidget extends StatefulWidget {
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
  State<_GiftsListWidget> createState() => _GiftsListWidgetState();
}

class _GiftsListWidgetState extends State<_GiftsListWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(() {
        if (_scrollController.position.extentAfter < 300) {
          context.read<GiftsBloc>().add(const GiftsAutoLoadingRequest());
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        Expanded(
          child: ListView.separated(
            controller: _scrollController,
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 32,
              top: 32 + mediaQuery.padding.top,
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount:
                widget.gifts.length + 1 + (_haveExtraBottomWidget ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Text(
                  'Подарки:',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                );
              }
              // Обработка ниженего элемента (отображение загрузки или ошибки в посленем элементе лист вью)
              if (index == widget.gifts.length + 1) {
                if (widget.showLoading) {
                  return const _ListViewLastProgressElement();
                } else {
                  if (!widget.showError) {
                    debugPrint(
                        'index == gifts.length + 1 but showLoading = false and showError = false');
                  }
                  return const _ListViewLastErrorElement();
                }
              }
              final gift = widget.gifts[index - 1];
              return _GiftCard(gift: gift);
            },
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  RouteName.gift.route,
                  arguments: const GiftPageArgs(giftName: null),
                ),
                child: const Text('Добавить подарок'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool get _haveExtraBottomWidget => widget.showLoading || widget.showError;
}

class _ListViewLastProgressElement extends StatelessWidget {
  const _ListViewLastProgressElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}

class _ListViewLastErrorElement extends StatelessWidget {
  const _ListViewLastErrorElement({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFFFE8F2),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Не удалось загрузить данные'),
          const Text('Попробуйте еще раз'),
          TextButton(
            onPressed: () =>
                context.read<GiftsBloc>().add(const GiftsLoadingRequest()),
            child: const Text('Попробовать еше раз'),
          ),
        ],
      ),
    );
  }
}

class _GiftCard extends StatelessWidget {
  const _GiftCard({
    Key? key,
    required this.gift,
  }) : super(key: key);

  final GiftDto gift;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        RouteName.gift.route,
        arguments: GiftPageArgs(
          giftId: gift.id,
          giftName: gift.name,
          giftLink: gift.link,
          giftPrice: gift.price,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    gift.name,
                    style: context.theme.h2,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    'GIFT ITEM',
                    style: context.theme.h3,
                  ),
                ],
              ),
            ),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.dividerColor,
              ),
              alignment: Alignment.center,
              child: Text('?',style: context.theme.h3,),
            )
          ],
        ),
      ),
    );
  }
}
