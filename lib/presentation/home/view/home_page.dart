import 'package:flutter/material.dart';
import 'package:gift_manager/data/storage/shared_preference_data.dart';
import 'package:gift_manager/presentation/login/view/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text("Home page"),
            SizedBox(
              height: 42,
            ),
            TextButton(
              onPressed: () async {
                await SharedPreferenceData.getInstance().setToken(null);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false);
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}
