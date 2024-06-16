import 'package:apollo_app/Application/main.dart';
import 'package:apollo_app/Features/Authentication/Presentation/View/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String id = '/';
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const MyHomePage(title: "Logged In"); // User is logged in
        } else {
          return const WelcomePage(); // User is NOT logged in
        }
      },
    );
  }
}
