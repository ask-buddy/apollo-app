import 'package:apollo_app/Features/Authentication/Login/Presentation/View/welcome_page.dart';
import 'package:apollo_app/Features/Common/Home/View/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String id = '/';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          // Need To refactor to correct page when ready
          return const HomePage(); // User is logged in
        } else {
          return const WelcomePage(); // User is NOT logged in
        }
      },
    );
  }
}
