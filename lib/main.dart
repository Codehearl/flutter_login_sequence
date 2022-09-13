import 'package:flutter/material.dart';
import 'package:course_app/views/login_view.dart';
import 'package:course_app/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:course_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        "/login/": ((context) => const LoginView()),
        "/register/": ((context) => const RegisterView())
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;

              // if (user?.emailVerified ?? false) {
              // } else {
              //   return const VerifyEmailView();
              // }
              // return const Text("done!");
              if (user?.isAnonymous ?? false) {
                return const RegisterView();
              }
               if (user?.emailVerified ?? false) {
                return const RegisterView();
              } else {
                return const RegisterView();
              }
              
            // print(user?.emailVerified);
            default:
              return const Text("Loading..");
          }
        },
      ),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white60.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                blurStyle: BlurStyle.solid)
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Verify Email Address",
              ),
              TextButton(
                  onPressed: (() async {
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                    print(user?.email);
                  }),
                  child: const Text("send email Verification"))
            ]),
      ),
    );
  }
}
