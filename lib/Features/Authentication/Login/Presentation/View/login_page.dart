import 'package:apollo_app/Core/Constants/colors.dart';
import 'package:apollo_app/Core/Constants/app_label.dart';
import 'package:apollo_app/Features/Authentication/Components/text_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../Application/main.dart';
import '../../../../../Core/Constants/image_strings.dart';
import '../../../../../Core/Constants/sizes.dart';

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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Logo, title
              const Text(
                ABTexts.loginTitle,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(ABTexts.loginSubTitle),

              /// Form
              const SizedBox(height: 24),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      // FIELD EMAIL
                      TextFormField(
                        controller: _emailTextController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: ABTexts.email,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // FIELD PASSWORD
                      TextFormField(
                        controller: _passwordTextController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: ABTexts.password,
                          suffixIcon: Icon(Icons.visibility_off),
                        ),
                      ),

                      // FORGOt PASSWORD
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(ABTexts.forgetPassword),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),

                      // BUTTON LOGIN
                      _showSpinner
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _doLogin,
                                child: const Text(ABTexts.signIn),
                              ),
                            ),
                      const SizedBox(height: 16),

                      // BUTTON SIGN UP
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text(ABTexts.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // DIVIDER
              const ABFormDivider(dividerText: ABTexts.orSignInWith),
              const SizedBox(height: 16),

              /// Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ABColors.stone),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: ABSizes.iconMd,
                        height: ABSizes.iconMd,
                        image: AssetImage(ABImages.apple),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: ABColors.stone),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Image(
                        width: ABSizes.iconMd,
                        height: ABSizes.iconMd,
                        image: AssetImage(ABImages.google),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
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
            MyHomePage.id,
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
