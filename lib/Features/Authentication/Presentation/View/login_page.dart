import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Application/main.dart';

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
        title: const Text("Login"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailTextController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
              ),
            ),
            _showSpinner
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: _doLogin,
                    child: const Text("Login"),
                  )
          ],
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
