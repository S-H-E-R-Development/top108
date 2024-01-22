import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> createOrUpdate(BuildContext context, CollectionReference product,
    [DocumentSnapshot? documentSnapshot]) async {
  final TextEditingController jobTitle_ = TextEditingController();
  final TextEditingController eligibility_ = TextEditingController();
  final TextEditingController applicationOpen_ = TextEditingController();
  final TextEditingController applicationEnd_ = TextEditingController();
  final TextEditingController additionMessage_ = TextEditingController();
  final TextEditingController about_ = TextEditingController();
  final TextEditingController jobType_ = TextEditingController();
  final TextEditingController stipend_ = TextEditingController();
  final TextEditingController url_ = TextEditingController();
  final TextEditingController company_ = TextEditingController();
  final TextEditingController postedBy_ = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  String action = 'create';
  if (documentSnapshot != null) {
    action = 'update';
    jobTitle_.text = documentSnapshot['jobTitle'];
    eligibility_.text = documentSnapshot['eligibility'];
    applicationOpen_.text = documentSnapshot['applicationOpen'];
    applicationEnd_.text = documentSnapshot['applicationEnd'];
    additionMessage_.text = documentSnapshot['additionMessage'];
    about_.text = documentSnapshot['about'];
    jobType_.text = documentSnapshot['jobType'];
    stipend_.text = documentSnapshot['stipend'];
    url_.text = documentSnapshot['url'];
    company_.text = documentSnapshot['company'];
    postedBy_.text = documentSnapshot['postedBy'];
  }
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
                  controller: jobTitle_,
                  decoration: InputDecoration(
                      label: Text(
                    "enter the title",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: jobType_,
                  decoration: InputDecoration(
                      label: Text(
                    "jobtype",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: eligibility_,
                  decoration: InputDecoration(
                      label: Text(
                    "eligibility",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: applicationOpen_,
                  decoration: InputDecoration(
                      label: Text(
                    "application open date",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: applicationEnd_,
                  decoration: InputDecoration(
                      label: Text(
                    "application close date",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  controller: additionMessage_,
                  decoration: InputDecoration(
                      label: Text(
                    "short additional message",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                RawKeyboardListener(
                  focusNode: FocusNode(),
                  onKey: (RawKeyEvent event) {
                    if (event is RawKeyDownEvent &&
                        event.isShiftPressed &&
                        event.logicalKey == LogicalKeyboardKey.enter) {
                      about_.text += '\n';
                    }
                  },
                  child: TextField(
                    maxLines: null,
                    autocorrect: true,
                    autofocus: true,
                    controller: about_,
                    decoration: InputDecoration(
                        label: Text(
                      "description of job",
                      style: GoogleFonts.aboreto(color: Colors.black45),
                    )),
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: stipend_,
                  decoration: InputDecoration(
                      label: Text(
                    "stipend/package in rupee",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: url_,
                  decoration: InputDecoration(
                      label: Text(
                    "apply link",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: company_,
                  decoration: InputDecoration(
                      label: Text(
                    "company name",
                    style: GoogleFonts.aboreto(color: Colors.black45),
                  )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: action == 'create'
                      ? const Icon(
                          Icons.send,
                          color: Colors.blue,
                        )
                      : const Text("update"),
                  onPressed: () async {
                    final String jobTitle = jobTitle_.text;
                    final String eligibility = eligibility_.text;
                    final String applicationOpen = applicationOpen_.text;
                    final String applicationEnd = applicationEnd_.text;
                    final String additionMessage = additionMessage_.text;
                    final String about = about_.text;
                    final String jobType = jobType_.text;
                    final String stipend = stipend_.text;
                    final String url = url_.text;
                    final String company = company_.text;
                    final String? postedBy = user.email;
                    try {
                      if (action == 'create') {
                        // Persist a new product to Firestore

                        product.add({
                          "jobTitle": jobTitle,
                          "eligibility": eligibility,
                          "applicationOpen": applicationOpen,
                          "applicationEnd": applicationEnd,
                          "additionMessage": additionMessage,
                          "about": about,
                          "jobType": jobType,
                          "stipend": stipend,
                          "url": url,
                          "company": company,
                          "postedBy": postedBy
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        product.doc(documentSnapshot!.id).update({
                          "jobTitle": jobTitle,
                          "eligibility": eligibility,
                          "applicationOpen": applicationOpen,
                          "applicationEnd": applicationEnd,
                          "additionMessage": additionMessage,
                          "about": about,
                          "jobType": jobType,
                          "stipend": stipend,
                          "url": url,
                          "company": company
                        });
                      }
                      displayMessage(context,
                          "successfully ${action == 'create' ? "added" : "updated"} ");
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
