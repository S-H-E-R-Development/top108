import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../community/forumPage.dart';
import '../profile/profilePage.dart';
import 'loginScreen.dart';

class AuthPage extends StatelessWidget {
  final String isProfileSelected;
  const AuthPage(this.isProfileSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          try {
            if (snapshot.hasData) {
              return isProfileSelected == 'profile'
                  ? ProfilePage1()
                  : const ChatPage();
            } else {
              //use is not logged in
              return const LoginPage();
            }
          } catch (e) {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
