import 'package:apollo_app/Core/Themes/Textstyle/AB_textstyle.dart';
import 'package:apollo_app/Features/Authentication/Login/Presentation/View/login_page.dart';
import 'package:apollo_app/Features/Authentication/SignUp/registration_page.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/Constants/app_label.dart';
import '../../../../../Core/Constants/colors.dart';
import '../../../../../Core/Constants/image_strings.dart';

class WelcomePage extends StatelessWidget {
  static String id = '/welcome';

  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),

                      Image(
                        width: MediaQuery.of(context).size.width / 2,
                        image: const AssetImage(ABImages.logoStuvy),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        ABTexts.stuvyTagline,
                        style: ABTextstyle.subtitleBold
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        ABTexts.onboardingDesc,
                        style:
                            ABTextstyle.body1.copyWith(color: ABColors.stone),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      //SIGNIN BUTTON
                      const SizedBox(height: 64),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginPage.id);
                          },
                          child: const Text(
                            ABTexts.signIn,
                            style: ABTextstyle.body1Medium,
                          ),
                        ),
                      ),

                      //CREATE ACCOUNT
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegistrationPage.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: ABColors.black,
                            side: BorderSide.none,
                            elevation: 0,
                          ),
                          child: const Text(
                            ABTexts.createAccount,
                            style: ABTextstyle.body1Medium,
                          ),
                        ),
                      ),

                      //CONTINUE AS GUSET
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ABTexts.contAs,
                            style: ABTextstyle.body1Bold
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ABTexts.aGuest,
                            style: ABTextstyle.body1Bold
                                .copyWith(color: ABColors.accent),
                          )
                        ],
                      ),
                      const SizedBox(height: 64)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
