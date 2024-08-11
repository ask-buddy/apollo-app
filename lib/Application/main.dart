import 'package:apollo_app/Core/Themes/themes.dart';
import 'package:apollo_app/Features/Capture/Presentation/Provider/capture_provider.dart';
import 'package:apollo_app/Features/Capture/Presentation/View/capture_page.dart';
import 'package:apollo_app/Features/Common/SplashScreen/View/splash_screen.dart';
import 'package:apollo_app/Features/Authentication/Login/Presentation/View/login_page.dart';
import 'package:apollo_app/Features/Authentication/SignUp/registration_page.dart';
import 'package:apollo_app/Features/Authentication/Login/Presentation/View/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import '../Core/Utilities/Firebase/firebase_options.dart';
import '../Features/Common/Home/View/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CaptureProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ABAppTheme.lightTheme,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomePage.id: (context) => WelcomePage(),
        LoginPage.id: (context) => const LoginPage(),
        RegistrationPage.id: (context) => const RegistrationPage(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
