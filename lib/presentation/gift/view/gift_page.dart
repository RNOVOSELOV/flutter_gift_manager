import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/extentions/theme_extensions.dart';
import 'package:gift_manager/presentation/gift/bloc/gift_bloc.dart';

class GiftPageArgs extends Equatable {
  final String? giftName;
  final String? giftId;
  final String? giftLink;
  final double? giftPrice;

  const GiftPageArgs({
    required this.giftName,
    this.giftId,
    this.giftLink,
    this.giftPrice,
  });

  @override
  List<Object?> get props => [giftName, giftId, giftLink, giftPrice];
}

class GiftPage extends StatelessWidget {
  const GiftPage({
    Key? key,
    required this.args,
  }) : super(key: key);

  final GiftPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<GiftBloc>()..add(GiftPageLoaded(args: args)),
      child: const _GiftPageWidget(),
    );
  }
}

class _GiftPageWidget extends StatefulWidget {
  const _GiftPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_GiftPageWidget> createState() => _GiftPageWidgetState();
}

class _GiftPageWidgetState extends State<_GiftPageWidget> {
  late final FocusNode _nameFocusNode;
  late final FocusNode _priceFocusNode;
  late final FocusNode _peopleFocusNode;
  late final FocusNode _linkFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _peopleFocusNode = FocusNode();
    _linkFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _peopleFocusNode.dispose();
    _linkFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Text(
                      'Добавить подарок',
                      style: context.theme.h2,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Можно заполнить только название',
                      style: context.theme.h6,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      focusNode: _nameFocusNode,
                      // onChanged: (text) => context
                      //    .read<RegistrationBloc>()
                      //    .add(RegistrationPasswordChanged(text)),
                      onSubmitted: (_) => _priceFocusNode.requestFocus(),
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                        labelText: "Название",
                        // errorText: error?.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      focusNode: _priceFocusNode,
                      // onChanged: (text) => context
                      //    .read<RegistrationBloc>()
                      //    .add(RegistrationPasswordChanged(text)),
                      onSubmitted: (_) => _peopleFocusNode.requestFocus(),
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Цена",
                        // errorText: error?.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      focusNode: _peopleFocusNode,
                      // onChanged: (text) => context
                      //    .read<RegistrationBloc>()
                      //    .add(RegistrationPasswordChanged(text)),
                      onSubmitted: (_) => _linkFocusNode.requestFocus(),
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Кому",
                        // errorText: error?.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      focusNode: _linkFocusNode,
                      // onChanged: (text) => context
                      //    .read<RegistrationBloc>()
                      //    .add(RegistrationPasswordChanged(text)),
                      onSubmitted: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      autocorrect: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Ссылка",
                        // errorText: error?.toString(),
                      ),
                    ),
                  ),
                  const _GoToLinkButton(),
                ],
              ),
            ),
            const _UpdateGiftButton(
              giftId: null,
            ),
            const _DeleteGiftButton(),
          ],
        ),
      ),
    );
  }
}

class _DeleteGiftButton extends StatelessWidget {
  const _DeleteGiftButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextButton(
          onPressed: () {},
          child: Text(
            "Удалить подарок",
            style: TextStyle(color: context.theme.hintColor),
          ),
        ),
      ),
    );
  }
}

class _GoToLinkButton extends StatelessWidget {
  const _GoToLinkButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: TextButton(
              onPressed: () {},
              child: const Text("Перейти по ссылке")),
        ),
        const Spacer(),
      ],
    );
  }
}

class _UpdateGiftButton extends StatelessWidget {
  final String? giftId;

  const _UpdateGiftButton({
    Key? key,
    required this.giftId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: BlocSelector<GiftBloc, GiftState, bool>(
          selector: (state) => state is GiftSavingInProgress,
          builder: (context, inProgress) {
            return ElevatedButton(
              onPressed: inProgress
                  ? null
                  : () => context
                      .read<GiftBloc>()
                      .add(const GiftInfoSendToServer()),
              child: Text(giftId == null ? "Добавить подарок" : "Сохранить"),
            );
          },
        ),
      ),
    );
  }
}
