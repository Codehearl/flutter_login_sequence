import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:course_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextField(
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          decoration: const InputDecoration(
            hintText: "Enter your email here",
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          controller: _password,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          keyboardType: TextInputType.visiblePassword,
          decoration: const InputDecoration(
            hintText: "Enter your password here",
            border: OutlineInputBorder(),
          ),
        ),
        TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                print("Something's wrong ");
                print(e.runtimeType);
                print(e);
                // TODO Handle all exceptions with new popups
              }
            },
            child: Text('Login')),
            //TODO redesign
      ]),
    );
  }
}
