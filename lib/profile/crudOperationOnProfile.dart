import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> crudOperationOnProfile(
  BuildContext context,
) async {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController affiliatedToController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
// Verify user is not null
  final user = FirebaseAuth.instance.currentUser!;

  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              // prevent the soft keyboard from covering text fields
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      label: Text(
                    "Enter user name",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: affiliatedToController,
                  decoration: InputDecoration(
                      label: Text(
                    "Institute name",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                      label: Text(
                    "Social Media URL",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text("update"),
                  onPressed: () async {
                    final String jobTitle = userNameController.text;
                    final String eligibility = affiliatedToController.text;

                    final String url = urlController.text;
                    try {
                      final db_ = FirebaseFirestore.instance;
                      await db_
                          .collection('publicUsers')
                          .doc(user.email)
                          .update(
                        {
                          'username': jobTitle,
                          'affiliatedTo': eligibility,
                          'urlLink': url
                        },
                      );
                      displayMessage(context, "successfully updated");
                    } catch (e) {
                      // Show a snackbar
                      displayMessage(context, "Sorry ! Network Error");
                    }
                    // Hide the bottom sheet
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      });
}

// Deleteing a product by id
Future<void> deleteProductItem(
    BuildContext context, CollectionReference product, String productId) async {
  try {
    product.doc(productId).delete();
  } catch (e) {
    displayMessage(context, "Network Error");
  }

  // Show a snackbar
  displayMessage(context, "post deletion successful !");
}

Future<void> displayMessage(BuildContext context, String? message) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    message!,
    style: GoogleFonts.aboreto(color: Colors.blueAccent),
  )));
}
