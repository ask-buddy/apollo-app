<<<<<<< HEAD
import 'package:apollo_app/Features/Authentication/Presentation/View/welcome_page.dart';
import 'package:apollo_app/Features/Explanation/Presentation/Provider/explanation_provider.dart';
import 'package:apollo_app/Features/Explanation/Presentation/View/explanation_page.dart';
import 'package:apollo_app/Features/QuestionGenerator/Presentation/Provider/generate_question_provider.dart';
import 'package:apollo_app/Features/Chat/Presentation/View/chat_page.dart';
import 'package:apollo_app/Features/QuestionGenerator/Presentation/View/generate_question_page.dart';
=======
import 'package:apollo_app/Features/Authentication/Login/Presentation/View/welcome_page.dart';
import 'package:apollo_app/Features/Capture/Presentation/Provider/capture_provider.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/capture_page.dart';
>>>>>>> 0a5567f991107742a25cdf9a335f89b75714c19f
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
        if (!snapshot.hasData) {
          // Need To refactor to correct page when ready
          return ChangeNotifierProvider(
<<<<<<< HEAD
            create: (context) => GenerateQuestionProvider(),
            child: const ChatPage(),
=======
            create: (context) => CaptureProvider(),
            child: const CapturePage(),
>>>>>>> 0a5567f991107742a25cdf9a335f89b75714c19f
          ); // User is logged in
        } else {
          return const WelcomePage(); // User is NOT logged in
        }
      },
    );
  }
}
