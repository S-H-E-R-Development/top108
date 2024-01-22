import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAHjC6mAe7-9V3_ugjJyZPfgxeaej1XRbc",
            authDomain: "top108-97bfd.firebaseapp.com",
            projectId: "top108-97bfd",
            storageBucket: "top108-97bfd.appspot.com",
            messagingSenderId: "842732551011",
            appId: "1:842732551011:web:94edc8e3eb59e1665d3156",
            measurementId: "G-5HJS5N7BN7"));
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Top108 Internship',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      // routes: <String, WidgetBuilder>{
      //   '/': (BuildContext context) => const HomeScreen(),
      //   '/opportunity': (BuildContext context) =>
      //       const VolunteeringOpportunity(),
      // },
    );
  }
}
