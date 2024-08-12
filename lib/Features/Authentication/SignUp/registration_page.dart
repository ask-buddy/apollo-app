import 'package:apollo_app/Features/Authentication/Login/Presentation/View/login_page.dart';
import 'package:apollo_app/Features/Common/Home/View/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Core/Constants/app_label.dart';
import '../../../Core/Constants/colors.dart';
import '../../../Core/Constants/image_strings.dart';
import '../../../Core/Constants/sizes.dart';
import '../../../Core/Themes/Textstyle/AB_textstyle.dart';
import '../Components/text_divider.dart';

class RegistrationPage extends StatefulWidget {
  static String id = '/register';
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                      Text(ABTexts.signUpTitle,
                          style: ABTextstyle.title1Medium
                              .copyWith(color: ABColors.secondaryLight)),
                      Text(
                        ABTexts.signUpSubTitle,
                        style: ABTextstyle.body1.copyWith(color: Colors.white),
                      ),

                      //FORM
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _emailTextController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: ABTexts.email,
                        ),
                      ),
                      const SizedBox(height: 24),
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
                      // BUTTON LOGIN
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _showSpinner ? null : _doRegisterUser,
                          child: _showSpinner
                              ? const SizedBox(
                                  width: 21,
                                  height: 21,
                                  child: CircularProgressIndicator(
                                    backgroundColor: ABColors.accent,
                                  ),
                                )
                              : const Text(
                                  ABTexts.createAcc,
                                  style: ABTextstyle.body1Medium,
                                ),
                        ),
                      ),
                      // DIVIDER
                      const Spacer(),
                      const ABFormDivider(dividerText: ABTexts.or),
                      const SizedBox(height: 22),

                      // Footer
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _doRegisterUser,
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
                            ABTexts.haveAcc,
                            style:
                                ABTextstyle.body1.copyWith(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                            child: Text(
                              ABTexts.signIn,
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

  void _doRegisterUser() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      await _auth
          .createUserWithEmailAndPassword(
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
