import 'package:apollo_app/Application/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                obscureText: true,
              ),
            ),
            _showSpinner
                ? const CircularProgressIndicator()
                : TextButton(
                    onPressed: _showSpinner ? null : _doRegisterUser,
                    child: const Text("Register"),
                  )
          ],
        ),
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
