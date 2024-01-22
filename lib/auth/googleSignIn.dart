import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signWithGoogle() async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth detail from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    //finally sign in
    await FirebaseAuth.instance.signInWithCredential(credential);

    String? userEmail = FirebaseAuth.instance.currentUser!.email;
    final db = FirebaseFirestore.instance;
    await db.collection('mentors').doc('guestlogin2app2023@gmail.com').set(
        {'$userEmail': 0.0},
        SetOptions(
          merge: true,
        ));
    final db0 = FirebaseFirestore.instance;
    await db0.collection('publicUsers').doc(userEmail).set(
        {'mentor': 'guestlogin2app2023@gmail.com'},
        SetOptions(
          merge: true,
        ));

    return;
  }
}
