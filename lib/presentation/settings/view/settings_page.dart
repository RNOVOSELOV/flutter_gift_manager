import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/extentions/theme_extensions.dart';
import 'package:gift_manager/presentation/settings/bloc/settings_bloc.dart';
import 'package:gift_manager/presentation/settings/models/theme_value.dart';
import 'package:gift_manager/resources/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl.get<SettingsBloc>()..add(const SettingsPageLoaded()),
      child: const _SettingsPageWidget(),
    );
  }
}

class _SettingsPageWidget extends StatelessWidget {
  const _SettingsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsParametersLoaded) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SettingsPageBlock(theme: state.theme!),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    height: 1,
                    color: AppColors.lightBlack8,
                  ),
                  _UserDataSettings(
                      name: state.userName,
                      email: state.userEmail,
                      avatarUri: state.userAvatarUrl),
                ]);
          }
          return const _LogoutButton();
        },
      ),
    );
  }
}

class _SettingsPageBlock extends StatefulWidget {
  const _SettingsPageBlock({Key? key, required this.theme}) : super(key: key);

  final ThemeValues theme;

  @override
  State<_SettingsPageBlock> createState() => _SettingsPageBlockState();
}

class _SettingsPageBlockState extends State<_SettingsPageBlock> {
  late bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _isDarkTheme = widget.theme == ThemeValues.dark;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: 24, top: 32 + mediaQuery.padding.top),
            child: Text(
              'Настроить',
              style: context.theme.h1,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          SwitchListTile.adaptive(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            title: Text(
              'Темная тема',
              style: context.theme.h3,
            ),
            autofocus: true,
            value: _isDarkTheme,
            onChanged: (value) {
              setState(() {
                _isDarkTheme = value;
              });
              context.read<SettingsBloc>().add(SettingsThemeChanged(
                  value: _isDarkTheme ? ThemeValues.dark : ThemeValues.light));
            },
          ),
        ]);
  }
}

class _UserDataSettings extends StatelessWidget {
  const _UserDataSettings({
    Key? key,
    required this.name,
    required this.email,
    required this.avatarUri,
  }) : super(key: key);

  final String? name;
  final String? email;
  final String? avatarUri;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text(
            'Мои данные',
            style: context.theme.h2,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (avatarUri != null)
                SvgPicture.network(
                  avatarUri!,
                  height: 56,
                  width: 56,
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      name ?? '',
                      style: context.theme.h3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      email ?? '',
                      style: context.theme.h4,
                    ),
                  ),
                  const _LogoutButton(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          context.read<SettingsBloc>().add(const SettingsLogout());
        },
        child: const Text('Выйти'));
  }
}
