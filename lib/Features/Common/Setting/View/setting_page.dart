import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Themes/Textstyle/AB_textstyle.dart';
import 'package:apollo_app/Features/Authentication/Login/Presentation/View/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  static const id = "/settings";

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Setting",
          style: ABTextstyle.title1Bold,
        ),
        backgroundColor: ABColors.deepSea,
        foregroundColor: ABColors.white,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: ABColors.deepSea,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 48,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    // Use a local variable to manage the state
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      await FirebaseAuth.instance.signOut();
                    } finally {
                      // Ensure state is updated after async operation
                      if (mounted) {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }

                    // Navigate after state update
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        WelcomePage.id,
                        (route) => false,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ABColors.white.withOpacity(0.08),
                    foregroundColor: ABColors.errorBrightRed,
                    textStyle: ABTextstyle.body1Bold,
                    side: const BorderSide(width: 0, color: Colors.transparent),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Log Out",
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
