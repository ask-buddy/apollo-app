import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Constants/app_label.dart';
import 'package:apollo_app/Core/Themes/Textstyle/AB_textstyle.dart';
import 'package:apollo_app/Features/Authentication/Components/text_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/Constants/image_strings.dart';
import '../../../../../Core/Constants/sizes.dart';
import '../../../../Common/Home/View/home_page.dart';
import '../../../SignUp/registration_page.dart';

class LoginPage extends StatefulWidget {
  static String id = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _showSpinner = false;

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: ABColors.deepSea,
        toolbarHeight: kToolbarHeight + 42,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo, title
                      Text(ABTexts.loginTitle,
                          style: ABTextstyle.title1Medium
                              .copyWith(color: ABColors.secondaryLight)),
                      Text(
                        ABTexts.loginSubTitle,
                        style: ABTextstyle.body1.copyWith(color: Colors.white),
                      ),

                      // Form
                      const SizedBox(height: 24),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: [
                              // FIELD EMAIL
                              TextFormField(
                                controller: _emailTextController,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: ABTexts.email,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // FIELD PASSWORD
                              TextFormField(
                                controller: _passwordTextController,
                                style: const TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: ABTexts.password,
                                  suffixIcon: Icon(Icons.visibility_off),
                                ),
                              ),

                              // FORGOT PASSWORD
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      ABTexts.forgetPassword,
                                      style: ABTextstyle.body1
                                          .copyWith(color: ABColors.accent),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 28),

                              // BUTTON LOGIN
                              _showSpinner
                                  ? const CircularProgressIndicator()
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _doLogin,
                                        child: const Text(
                                          ABTexts.signIn,
                                          style: ABTextstyle.body1Medium,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // DIVIDER
                      const Spacer(),
                      const ABFormDivider(dividerText: ABTexts.or),
                      const SizedBox(height: 22),

                      // Footer
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _doLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: ABColors.black,
                            side: BorderSide.none,
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                width: ABSizes.iconMd,
                                height: ABSizes.iconMd,
                                image: AssetImage(ABImages.google),
                              ),
                              SizedBox(width: 8),
                              Text(
                                ABTexts.signGoogle,
                                style: ABTextstyle.body1Medium,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ABTexts.dontHaveAcc,
                            style:
                                ABTextstyle.body1.copyWith(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, RegistrationPage.id);
                            },
                            child: Text(
                              ABTexts.createAcc,
                              style: ABTextstyle.body1
                                  .copyWith(color: ABColors.accent),
                            ),
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

  void _doLogin() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      await _auth
          .signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      )
          .then(
        (user) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.id,
            (route) => false,
          );
        },
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
