import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  _DeleteAccountPageState createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you want to delete your account?',
              style: GoogleFonts.patuaOne(
                  textStyle: const TextStyle(color: Colors.purple)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Delete Account'),
              onPressed: () {
                showConfirmationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Text('Are you sure you want to delete your account?',
              style: GoogleFonts.patuaOne(
                  textStyle: const TextStyle(color: Colors.purple))),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
      Navigator.of(context).pop();
      // Optionally, you can navigate to a success page or show a success message.
    } catch (e) {
      // Handle any errors that occurred during the account deletion.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting account: $e')));

      // You can show an error message or handle the error as needed.
    }
  }
}
