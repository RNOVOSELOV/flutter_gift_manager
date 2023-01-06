import 'package:flutter/material.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/domain/logout_interactor.dart';
import 'package:gift_manager/navigation/route_name.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
            onPressed: () async {
              sl.get<LogoutInteractor>().logout();
            },
            child: const Text('Logout')),
      ),
    );
  }
}
