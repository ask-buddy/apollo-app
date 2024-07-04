import 'package:apollo_app/Features/Authentication/Presentation/View/welcome_page.dart';
import 'package:apollo_app/Features/Explanation/Presentation/Provider/explanation_provider.dart';
import 'package:apollo_app/Features/Explanation/Presentation/View/explanation_page.dart';
import 'package:apollo_app/Features/QuestionGenerator/Presentation/Provider/generate_question_provider.dart';
import 'package:apollo_app/Features/QuestionGenerator/Presentation/View/generate_question_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          return ChangeNotifierProvider(
            create: (context) => GenerateQuestionProvider(),
            child: const GenerateQuestionPage(),
          ); // User is logged in
        } else {
          return const WelcomePage(); // User is NOT logged in
        }
      },
    );
  }
}
