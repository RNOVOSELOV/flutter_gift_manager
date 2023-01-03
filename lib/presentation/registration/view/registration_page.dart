import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/extentions/build_context.dart';
import 'package:gift_manager/extentions/theme_extensions.dart';
import 'package:gift_manager/presentation/registration/bloc/registration_bloc.dart';
import 'package:gift_manager/resources/app_colors.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: const Scaffold(
        body: _RegistrationPageWidget(),
      ),
    );
  }
}

class _RegistrationPageWidget extends StatefulWidget {
  const _RegistrationPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_RegistrationPageWidget> createState() =>
      _RegistrationPageWidgetState();
}

class _RegistrationPageWidgetState extends State<_RegistrationPageWidget> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding:
                const EdgeInsets.only(left: 8, top: 6, bottom: 6, right: 4),
            decoration: BoxDecoration(
              color: context.dynamicPlaneColor(
                lightThemeColor: AppColors.lightLightBlue100,
                darkThemeColor: AppColors.darkWhite20,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Ваш аватар',
                  style: context.theme.h3,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => context
                      .read<RegistrationBloc>()
                      .add(const RegistrationChangeAvatar()),
                  child: const Text('Изменить'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
