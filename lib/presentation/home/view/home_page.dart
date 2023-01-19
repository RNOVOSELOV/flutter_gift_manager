import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/navigation/route_name.dart';
import 'package:gift_manager/presentation/gifts/view/gifts_page.dart';
import 'package:gift_manager/presentation/home/bloc/home_bloc.dart';
import 'package:gift_manager/presentation/home/models/bottom_tab.dart';
import 'package:gift_manager/presentation/peoples/view/peoples_page.dart';
import 'package:gift_manager/presentation/settings/view/settings_page.dart';

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

class _HomePageWidget extends StatefulWidget {
  const _HomePageWidget({Key? key}) : super(key: key);

  @override
  State<_HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<_HomePageWidget> {
  BottomTab _currentTab = BottomTab.gifts;

  final _pages = const <BottomTab, Widget>{
    BottomTab.gifts: GiftsPage(),
    BottomTab.peoples: PeoplesPage(),
    BottomTab.settings: SettingsPage(),
  };

  void _changeTab(int index) {
    setState(() {
      _currentTab = BottomTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeGoToLogin) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(RouteName.login.route, (route) => false);
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab.index,
          onTap: _changeTab,
          items: <BottomNavigationBarItem>[
            _createBottomNavBarItem(BottomTab.gifts),
            _createBottomNavBarItem(BottomTab.peoples),
            _createBottomNavBarItem(BottomTab.settings),
          ],
        ),
        body: IndexedStack(
          index: _currentTab.index,
          children: _pages.values.toList(),
        ),
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavBarItem(BottomTab tab) {
    return BottomNavigationBarItem(
      icon: Icon(tab.icon),
      label: tab.label,
    );
  }
}
