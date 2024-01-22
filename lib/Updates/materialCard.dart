import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'crudOperations.dart';

Widget addCard(BuildContext context, CollectionReference product,
    DocumentSnapshot documentSnapshot, bool accessToken) {
  final String jobTitle = documentSnapshot['jobTitle'];
  final String eligibility = documentSnapshot['eligibility'];
  final String applicationOpen = documentSnapshot['applicationOpen'];
  final String applicationEnd = documentSnapshot['applicationEnd'];
  final String additionMessage = documentSnapshot['additionMessage'];
  final String about = documentSnapshot['about'];
  final String jobType = documentSnapshot['jobType'];
  final String stipend = documentSnapshot['stipend'];
  final String url = documentSnapshot['url'];
  final String postedBy = documentSnapshot['postedBy'];

  final user = FirebaseAuth.instance.currentUser!;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
        child: Text(
          jobTitle,
          style: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.blue),
        ),
      ),
      Text("Eligibility $eligibility", textAlign: TextAlign.left),
      Text(
        "application open $applicationOpen",
        textAlign: TextAlign.left,
      ),
      Text("application close $applicationEnd"),
      const SizedBox(
        height: 8,
      ),
      Text(
        additionMessage,
        style: GoogleFonts.abhayaLibre(
          color: Colors.brown,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                focusColor: Colors.white,
                onPressed: () => popupProfile(context, postedBy),
                icon: const Icon(
                  Icons.thumb_up,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                focusColor: Colors.white,
                onPressed: () => shareContent(
                    context, jobTitle, jobType, stipend, eligibility),
                icon: const Icon(
                  Icons.share,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              ElevatedButton(
                  onPressed: () => popUPCard(context,
                      about: about,
                      additionMessage: additionMessage,
                      applicationEnd: applicationEnd,
                      applicationOpen: applicationOpen,
                      eligibility: eligibility,
                      jobType: jobType,
                      jobTitle: jobTitle,
                      stipend: stipend,
                      url: url,
                      postedBy: postedBy),
                  child: const Text("know more")),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                  onPressed: () => launchUrl(Uri.parse(url)),
                  child: const Text("apply")),
            ],
          ),
        ),
      ),
      // update is delete should can be seen by accessToken
      (accessToken == true && postedBy == user.email)
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        createOrUpdate(context, product, documentSnapshot);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 136, 194, 242),
                      ),
                      hoverColor: Colors.pink,
                      splashColor: Colors.amber),
                  const SizedBox(
                    width: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        deleteProductItem(
                            context, product, documentSnapshot.id);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 156, 206, 248),
                      ),
                      hoverColor: const Color.fromARGB(255, 195, 180, 241),
                      splashColor: const Color.fromARGB(255, 213, 182, 243)),
                ],
              ),
            )
          : const SizedBox(
              width: 0,
            ),
      const Divider(
        height: 4,
        thickness: 1,
        color: Color.fromARGB(255, 56, 68, 248),
      ),
      const SizedBox(
        height: 5,
      )
    ],
  );
}

Future<void> popupProfile(BuildContext context, String postedBy) async {
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await FirebaseFirestore.instance
          .collection('publicUsers')
          .doc(postedBy)
          .get();

  return showDialog(
    context: context,
    builder: (context) => Dialog(
      alignment: Alignment.bottomRight,
      backgroundColor: const Color.fromARGB(100, 33, 32, 32),
      child: SizedBox(
        height: 70,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    documentSnapshot['username'],
                    style:
                        GoogleFonts.aBeeZee(fontSize: 10, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                      onPressed: () => launchUrl(
                          Uri.parse(documentSnapshot['urlLink'].toString())),
                      child: Text(
                        "connect+",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 11,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ))
                ]),
            Text(
              documentSnapshot['affiliatedTo'],
              style: GoogleFonts.aBeeZee(fontSize: 8, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    ),
  );
}

shareContent(BuildContext context, String jobTitle, String jobType,
    String stipend, String eligibility) async {
  await Share.share('''
🚀$jobTitle🚀 - $jobType
Eligibility- $eligibility


Check it out on top108.web.app ! 
\n https://top108.web.app/ ''',
      subject: "TOP 108 Companies updates",
      sharePositionOrigin:
          Rect.fromCenter(center: Offset.zero, width: 30, height: 20));
}

popUPCard(BuildContext context,
    {required String jobTitle,
    required String eligibility,
    required String applicationOpen,
    required String applicationEnd,
    required String additionMessage,
    required String stipend,
    required String about,
    required String jobType,
    required String url,
    required String postedBy}) {
  return showDialog(
    barrierColor: Colors.white,
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.cyan[50],
      actions: const [],
      title: Text(
        jobTitle,
        style: GoogleFonts.aBeeZee(
            fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "application open: $applicationOpen",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    "application close: $applicationEnd ",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Stipend $stipend ",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.abel(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    jobType.toUpperCase(),
                    textAlign: TextAlign.end,
                    style: GoogleFonts.abel(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            Text(
              "Eligibility",
              style:
                  GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              eligibility,
              style:
                  GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "About",
              style:
                  GoogleFonts.abel(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.left,
            ),
            Text(
              about,
              style: GoogleFonts.abel(),
              overflow: TextOverflow.visible,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: const ButtonStyle(
                  alignment: Alignment.center,
                ),
                autofocus: true,
                onPressed: () => launchUrl(Uri.parse(url)),
                child: Center(
                    child: Text(
                  "apply",
                  style: GoogleFonts.abel(
                      fontWeight: FontWeight.bold, fontSize: 15),
                )),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
