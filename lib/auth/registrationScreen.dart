// ignore_for_file: use_build_context_synchronously
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'my_textfield.dart';
//
// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});
//
//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }
//
// class _SignUpPageState extends State<SignUpPage> {
//   // text editing controller
//
//   final emailAddress = TextEditingController();
//
//   final password = TextEditingController();
//   final confirmPassword = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//       backgroundColor: Colors.green[50],
//       body: ListView(
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           //logo
//
//           //welcome
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//                 child: Text(
//               "S H E R",
//               style: GoogleFonts.akayaTelivigala(
//                   textStyle: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 38,
//               )),
//             )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(
//                 child: Text(
//               "A  STEP  TOWARDS  DEGITALIZATION",
//               style: GoogleFonts.pacifico(
//                   textStyle: const TextStyle(
//                 color: Colors.blueGrey,
//               )),
//             )),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//
//           //username textfield
//           MyTextField(
//             controller: emailAddress,
//             hintText: 'Email',
//             obscureText: false,
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           //passward textfield
//           MyTextField(
//             controller: password,
//             hintText: 'Password',
//             obscureText: true,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           MyTextField(
//             controller: confirmPassword,
//             hintText: 'Confirm Password',
//             obscureText: true,
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Text("New User ? "),
//               // SizedBox(
//               //   width: 20,
//               // ),
//               FloatingActionButton.extended(
//                 onPressed: () {
//                   signUserUp();
//                 },
//                 heroTag: 'register',
//                 elevation: 5,
//                 hoverColor: Colors.amber,
//                 hoverElevation: 7,
//                 backgroundColor: Colors.black,
//                 splashColor: Colors.amber,
//                 label: const Text("Register Now"),
//                 icon: const Icon(
//                   Icons.supervised_user_circle,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 40,
//           ),
//           //container with +
//           Row(
//             children: [
//               Expanded(
//                   child: Divider(
//                 color: Colors.blue[60],
//                 thickness: 0.5,
//               )),
//               const Text(" NOTE :- YOU ARE REGISTERING AS A GUEST "),
//               Expanded(
//                   child: Divider(
//                 color: Colors.blue[60],
//                 thickness: 0.5,
//               ))
//             ],
//           ),
//           // const SizedBox(
//           //   height: 40,
//           // ),
//           // //google
//           //
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.center,
//           //   children: [
//           //     SquareTileButton(
//           //       onTap: () {
//           //         showDialog(
//           //             context: context,
//           //             builder: (context) {
//           //               return const Center(child: CircularProgressIndicator());
//           //             });
//           //         //signup + categories to which mentor new belongs
//           //         //by default it is guest
//           //         AuthService().signWithGoogle();
//           //         Navigator.pop(context);
//           //       },
//           //       logoPath: 'assets/googleLogo.png',
//           //     ),
//           //     const SizedBox(
//           //       width: 25,
//           //     ),
//           //     SquareTileButton(
//           //       logoPath: 'assets/facebookLogo.png',
//           //       onTap: () => {},
//           //     )
//           //   ],
//           // ),
//           // const SizedBox(
//           //   height: 20,
//           // ),
//
//           //not a member ? register now
//         ],
//       ),
//     );
//   }
//
//   void signUserUp() async {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return const Center(child: CircularProgressIndicator());
//         });
//     // await FirebaseAuth.instance.signInWithEmailAndPassword(
//     //     email: emailAddress.text, password: password.text);
//     try {
//       //check confirm pass and passwrod
//       if (password.text == confirmPassword.text) {
//         final db = FirebaseFirestore.instance;
//         await db
//             .collection('mentors')
//             .doc('guestlogin2app2023@gmail.com')
//             .set({emailAddress.text: 0.0}, SetOptions(merge: true));
//         final db_ = FirebaseFirestore.instance;
//         await db_.collection('publicUsers').doc(emailAddress.text).set(
//             {'mentor': 'guestlogin2app2023@gmail.com'},
//             SetOptions(merge: true));
//
//         //tring to SignUp
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             email: emailAddress.text, password: confirmPassword.text);
//         Navigator.pop(context);
//         errorMessage(" Congratulations ! ");
//         return;
//       } else {
//         Navigator.pop(context);
//         errorMessage("Password Mismatch");
//         return;
//       }
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);
//       errorMessage(e.code);
//     }
//
//     return;
//   }
//
//   void errorMessage(String error) {
//     showDialog(
//         context: context,
//         builder: (context) => Center(
//               child: AlertDialog(
//                 title: Text(error),
//               ),
//             ));
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controller
  final emailAddress = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "S H E R",
                style: GoogleFonts.akayaTelivigala(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 38,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "A  STEP  TOWARDS EMPOWERING EMPLOYMENT",
                style: GoogleFonts.pacifico(
                  textStyle: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MyTextField(
            controller: emailAddress,
            hintText: 'Email',
            obscureText: false,
          ),
          const SizedBox(
            height: 15,
          ),
          MyTextField(
            controller: password,
            hintText: 'Password',
            obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
            controller: confirmPassword,
            hintText: 'Confirm Password',
            obscureText: true,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                onPressed: () {
                  signUserUp();
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
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.blue[60],
                  thickness: 0.5,
                ),
              ),
              const Text(" NOTE: ENTER VALID EMAIL"),
              Expanded(
                child: Divider(
                  color: Colors.blue[60],
                  thickness: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Check if password and confirm password match
      if (password.text == confirmPassword.text) {
        // Create user with email and password
        final UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.text,
          password: confirmPassword.text,
        );

        // Verify user is not null
        final User? user = userCredential.user;
        if (user != null) {
          // Store user data in Firestore
          // final db = FirebaseFirestore.instance;
          // await db
          //     .collection('mentors')
          //     .doc("guestlogin2app2023@gmail.com")
          //     .set(
          //   {emailAddress.text: 0.0},
          //   SetOptions(merge: true),
          // );

          final db_ = FirebaseFirestore.instance;
          await db_.collection('publicUsers').doc(user.email).set(
            {
              'username': '?',
              'isAmbasdor': false,
              'affiliatedTo': '?',
              'urlLink': ''
            },
            SetOptions(merge: true),
          );

          Navigator.pop(context);
          errorMessage("Congratulations!");
        } else {
          Navigator.pop(context);
          errorMessage("An error occurred while creating the user.");
        }
      } else {
        Navigator.pop(context);
        errorMessage("Password mismatch");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      errorMessage(e.code);
    }
  }

  void errorMessage(String error) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: AlertDialog(
          title: Text(error),
        ),
      ),
    );
  }
}
