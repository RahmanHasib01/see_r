import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:see_r/home_page.dart';
import 'package:see_r/signin.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking authentication state
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          // User is authenticated, redirect to the signed-in page
          return const HomePage();
        } else {
          // User is not authenticated, show the sign-in page
          return const SigninPage();
        }
      },
    );
  }
}
