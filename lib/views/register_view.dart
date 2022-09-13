import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:course_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: TextField(
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          controller: _email,
          decoration: const InputDecoration(
            hintText: "Enter your email here",
            border: OutlineInputBorder(),
          ),
        ),
      ),
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: TextField(
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
      ),
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: InkWell(
          onTap: () async {
            final email = _email.text;
            final password = _password.text;
            try {
              final userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: email, password: password);
              print(userCredential);
            } on FirebaseAuthException catch (e) {
              print(e.runtimeType);
              switch (e.code) {
                case "The email address is already in use by another account.s":
                  print("LoL");
                  //TODO: POPUP for email address already in use
                  break;
                case "invalid-email":
                  print("email");
                  // /TODO: POPUP for invalid-email
                  break;
                case "wrong-password":
                  print("password");
                  // /TODO: POPUP for email address already in use
                  break;
                default:
                  print(e.code);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0)),
            child: const Text("Register"),
          ),
        ),
      ),
    ]);
  }
}
