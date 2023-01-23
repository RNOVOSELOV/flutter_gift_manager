import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gift_manager/data/http/model/persons_dto.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/extensions/theme_extensions.dart';
import 'package:gift_manager/helpers.dart';
import 'package:gift_manager/presentation/peoples/bloc/peoples_bloc.dart';
import 'package:gift_manager/resources/app_illustrations.dart';

class PeoplesPage extends StatelessWidget {
  const PeoplesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<PeoplesBloc>()..add(const PeoplesPageLoaded()),
      child: const _PeoplesPageWidget(),
    );
  }
}

class _PeoplesPageWidget extends StatelessWidget {
  const _PeoplesPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PeoplesBloc, PeoplesState>(
        builder: (context, state) {
          if (state is PeoplesLoadingState) {
            // SHOW LOADING STATE
            return const _LoadingWidget();
          } else if (state is PeoplesLoadedEmptyState) {
            // SHOW NO GIFTS STATE
            return const _NoPeoplesWidget();
          } else if (state is PeoplesLoadingErrorState) {
            // SHOW LOADING ERROR
            return const _LoadingErrorWidget();
          } else if (state is PeoplesLoadedState) {
            return _PeoplesGridWidget(
              peoples: state.peoples,
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

class _NoPeoplesWidget extends StatelessWidget {
  const _NoPeoplesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        SvgPicture.asset(AppIllustrations.noPeoples),
        const SizedBox(
          height: 37,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Место для самых близких людей',
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

class _LoadingErrorWidget extends StatelessWidget {
  const _LoadingErrorWidget({Key? key}) : super(key: key);

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
                context.read<PeoplesBloc>().add(const PeoplesLoadingRequest()),
            child: Text('Попробовать снова'.toUpperCase()),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class _PeoplesGridWidget extends StatelessWidget {
  const _PeoplesGridWidget({
    Key? key,
    required this.peoples,
    required this.showError,
    required this.showLoading,
  }) : super(key: key);

  final List<PersonsDto> peoples;
  final bool showError;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        const Text(
          'Подарки:',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        GridView.extent(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 32,
            top: 32 + mediaQuery.padding.top,
          ),
          childAspectRatio: 1,
          maxCrossAxisExtent: 170,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children:  _getGridElements(context, peoples),
        ),
      ],
    );
  }

  List<Widget> _getGridElements(
      BuildContext context, List<PersonsDto> peoples) {
    final listItems = <Container>[];
    for (PersonsDto person in peoples) {
      Container container = Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Container(
              margin: const EdgeInsets.only(left: 12),
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).dividerColor,
              ),
              alignment: Alignment.center,
              child: Text(
                '?',
                style: Theme.of(context).h3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(person.name, style: context.theme.h2,),
            ),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(getGiftCountString(10),style: context.theme.h3,),
            ),
          ],
        ),
      );
      listItems.add(container);
    }
    return listItems;
  }
}
