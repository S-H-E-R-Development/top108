import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'my_textfield.dart';
import 'registrationScreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller

  final _emailController = TextEditingController();

  final password = TextEditingController();
  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  Future forgotPassword() async {
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      error_message(
          "Please Check Your Email ! & Reset Your Password ! Make Sure You Have Entered Right Email !");
    } on FirebaseAuthException catch (e) {
      error_message(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ClipRect(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 0,
                ),
                //logo
                // const Center(
                //   child:
                //       Image(image: AssetImage("assets/SHER.png"), fit: BoxFit.cover),
                // ),
                const SizedBox(
                  height: 15,
                ),
                //welcome
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text('''
                                        WELCOME ! 
To The TOP 108 Companies Internship Update powered by Society of Humanity Education & Research''',
                          style: GoogleFonts.taiHeritagePro(
                              textStyle: const TextStyle(
                                  color: Colors.blueGrey, fontSize: 16)))),
                ),
                const SizedBox(
                  height: 30,
                ),

                //username textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'username/email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 8,
                ),
                //passward textfield
                MyTextField(
                  controller: password,
                  hintText: 'password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                //forgot passward
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => forgotPassword(),
                          child: Text("Forgot Password",
                              style: GoogleFonts.patuaOne(
                                  textStyle:
                                      const TextStyle(color: Colors.purple))))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 85.0),
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          });
                      signUserIn();
                      Navigator.pop(context);
                    },
                    heroTag: 'signIn',
                    elevation: 5,
                    splashColor: Colors.amber,
                    backgroundColor: Colors.black,
                    label: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
                  ),
                ),
                // MyButton(onTap: SignUserIn),

                const SizedBox(
                  height: 16,
                ),
                //container with +
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: Colors.blue[60],
                      thickness: 0.5,
                    )),
                    Text("Register Now To Create Account",
                        style: GoogleFonts.patuaOne(
                            textStyle: const TextStyle(color: Colors.black))),
                    Expanded(
                        child: Divider(
                      color: Colors.blue[60],
                      thickness: 0.5,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                //google

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SquareTileButton(
                //       onTap: () => signInWithGoogle(),
                //       logoPath: 'assets/googleLogo.png',
                //     ),
                //     const SizedBox(
                //       width: 25,
                //     ),
                //     SquareTileButton(
                //       logoPath: 'assets/facebookLogo.png',
                //       onTap: () => {},
                //     )
                //   ],
                // ),
                // FloatingActionButton.small(
                //     onPressed: () => signInWithGoogleWeb(), child: Text("google")),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      heroTag: 'register',
                      elevation: 5,
                      hoverColor: Colors.amber,
                      hoverElevation: 7,
                      backgroundColor: Colors.black,
                      splashColor: Colors.amber,
                      label: const Text(
                        "Register Now",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.supervised_user_circle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )

                //not a member ? register now
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUserIn() async {
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: _emailController.text, password: password.text);
    try {
      //tring to signin
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: password.text);
      // Navigator.pop(context);
    }
    //on exception
    on FirebaseAuthException catch (e) {
      // Navigator.pop(context);
      error_message(e.code);
    }
  }

  Future<void> error_message(String error) async => showDialog(
      context: context,
      builder: (context) => Center(
            child: AlertDialog(
              title: Text(error,
                  style: GoogleFonts.patuaOne(
                      textStyle: const TextStyle(color: Colors.black))),
            ),
          ));

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGoogleWeb() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    // googleProvider.setCustomParameters();

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }
}
