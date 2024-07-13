import 'package:apollo_app/Features/Authentication/Login/Presentation/View/login_page.dart';
import 'package:apollo_app/Features/Authentication/SignUp/registration_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  static String id = '/welcome';

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('WELCOME !'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationPage.id);
                },
                child: const Text("Register"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
