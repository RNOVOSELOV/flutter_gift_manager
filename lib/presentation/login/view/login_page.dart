import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _LoginPageWidget(),
    );
  }
}

class _LoginPageWidget extends StatelessWidget {
  const _LoginPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 64,
        ),
        const Center(
          child: Text(
            "Вход",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        const Spacer(
          flex: 88,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: TextField(
            decoration: InputDecoration(hintText: "Почта"),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 36),
          child: TextField(
            decoration: InputDecoration(hintText: "Пароль"),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => debugPrint("Enter button pressed"),
              child: const Text("Войти"),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Ещё нет аккаунта?"),
            TextButton(
                onPressed: () => debugPrint("Buttorn create pressed"),
                child: const Text("Создать")),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        TextButton(
            onPressed: () => debugPrint("Don't know password"),
            child: const Text("Не помню пароль")),
        const Spacer(
          flex: 284,
        ),
      ],
    );
  }
}
