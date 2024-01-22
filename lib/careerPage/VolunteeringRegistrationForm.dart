import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VolunteeringOpportunity extends StatefulWidget {
  const VolunteeringOpportunity({super.key});

  @override
  State<VolunteeringOpportunity> createState() =>
      _VolunteeringOpportunityState();
}

class _VolunteeringOpportunityState extends State<VolunteeringOpportunity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController instituteNameController = TextEditingController();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController shortDescriptionAboutYouController =
      TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  String? get userEmail => FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Current Opportunity at 108",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.abel(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 71, 25, 25),
              decoration: TextDecoration.underline,
              fontSize: width > 700 ? 55 : 30,
            ),
          ),
        ),
        body: width < 600
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          // height: 300,
                          width: width,
                          child: Image(
                            image: const AssetImage(
                              "assets/VB1POSTER-1.png",
                            ),
                            // width: 348 - 25000 / (width + 1),
                            height: 236 - 25000 / (width + 1),
                            semanticLabel: 'TOP108INTERNSHIP',
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          // height: 300,
                          width: width,
                          child: const Image(
                            image: AssetImage(
                              "assets/VB1POSTER-2.png",
                            ),
                            fit: BoxFit.contain,
                            // width: 348 - 25000 / (width + 1),
                            // height:
                            //     236 - 25000 / (((width + height) / 2) + 1),
                            semanticLabel: 'TOP108INTERNSHIP',
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Volunteer Form",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blue, fontSize: 15),
                        ),
                        Text(
                          "Your Name",
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blueGrey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: width > 500 ? 400 : width - 100,
                          child: TextField(
                            style: GoogleFonts.aBeeZee(fontSize: 13),
                            cursorColor: Colors.purple,
                            autocorrect: true,
                            canRequestFocus: true,
                            controller: nameController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                label: Text(
                                  "type here..",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.blueGrey, fontSize: 12),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Your Institute Name",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: width > 500 ? 400 : width - 100,
                          child: TextField(
                            style: GoogleFonts.aBeeZee(fontSize: 13),
                            cursorColor: Colors.purple,
                            autocorrect: true,
                            canRequestFocus: true,
                            controller: instituteNameController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                label: Text(
                                  "type here..",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.blueGrey, fontSize: 12),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Your Course Name",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: width > 500 ? 400 : width - 100,
                          child: TextField(
                            style: GoogleFonts.aBeeZee(fontSize: 13),
                            cursorColor: Colors.purple,
                            autocorrect: true,
                            canRequestFocus: true,
                            controller: courseNameController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                label: Text(
                                  "type here..",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.blueGrey, fontSize: 12),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Your Email",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: width > 500 ? 400 : width - 100,
                          child: TextField(
                            style: GoogleFonts.aBeeZee(fontSize: 13),
                            cursorColor: Colors.purple,
                            autocorrect: true,
                            canRequestFocus: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                label: Text(
                                  "enter valid email..",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.blueGrey, fontSize: 12),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Your Mobile Number",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: width > 500 ? 400 : width - 100,
                          child: TextField(
                            style: GoogleFonts.aBeeZee(fontSize: 13),
                            cursorColor: Colors.purple,
                            autocorrect: true,
                            canRequestFocus: true,
                            keyboardType: TextInputType.phone,
                            controller: mobileNumberController,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                label: Text(
                                  "Enter valid mobile number..",
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.aBeeZee(
                                      color: Colors.blueGrey, fontSize: 12),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Short Description about Your Academic",
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.aBeeZee(
                              color: Colors.blueGrey, fontSize: 12),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: width > 500 ? 400 : width - 40,
                          child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (RawKeyEvent event) {
                              if (event is RawKeyDownEvent &&
                                  event.isShiftPressed &&
                                  event.logicalKey ==
                                      LogicalKeyboardKey.enter) {
                                shortDescriptionAboutYouController.text += '\n';
                              }
                            },
                            child: TextField(
                              style: GoogleFonts.aBeeZee(fontSize: 13),
                              cursorColor: Colors.purple,
                              autocorrect: true,
                              canRequestFocus: true,
                              maxLines: null,
                              textInputAction: TextInputAction.none,
                              keyboardType: TextInputType.multiline,
                              controller: shortDescriptionAboutYouController,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)))),
                              // onSubmitted: (value) {
                              //   _sendMessage(_messageController.text, '');
                              // },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        FloatingActionButton.extended(
                            extendedPadding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 0),
                            splashColor:
                                const Color.fromARGB(200, 163, 219, 244),
                            hoverColor: Colors.white,
                            backgroundColor:
                                const Color.fromARGB(198, 198, 209, 232),
                            onPressed: () {
                              if (FirebaseAuth.instance.currentUser != null) {
                                submitApplication(context);
                              } else {
                                showMessage(context, "Please Sign In");
                              }
                            },
                            label: Text("Submit Application",
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 14, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 300,
                              width: width - 500,
                              child: Image(
                                image: const AssetImage(
                                  "assets/VB1POSTER-1.png",
                                ),
                                // width: 348 - 25000 / (width + 1),
                                height: 236 - 25000 / (width + 1),
                                semanticLabel: 'TOP108INTERNSHIP',
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              width: width - 500,
                              child: const Image(
                                image: AssetImage(
                                  "assets/VB1POSTER-2.png",
                                ),
                                fit: BoxFit.contain,
                                // width: 348 - 25000 / (width + 1),
                                // height:
                                //     236 - 25000 / (((width + height) / 2) + 1),
                                semanticLabel: 'TOP108INTERNSHIP',
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Volunteer Form",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blue, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Your Name",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blueGrey, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: width > 500 ? 400 : width - 100,
                              child: TextField(
                                style: GoogleFonts.aBeeZee(fontSize: 13),
                                cursorColor: Colors.purple,
                                autocorrect: true,
                                canRequestFocus: true,
                                controller: nameController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    label: Text(
                                      "type here..",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.blueGrey, fontSize: 12),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Your Institute Name",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blueGrey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: width > 500 ? 400 : width - 100,
                              child: TextField(
                                style: GoogleFonts.aBeeZee(fontSize: 13),
                                cursorColor: Colors.purple,
                                autocorrect: true,
                                canRequestFocus: true,
                                controller: instituteNameController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    label: Text(
                                      "type here..",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.blueGrey, fontSize: 12),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Your Course Name",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blueGrey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: width > 500 ? 400 : width - 100,
                              child: TextField(
                                style: GoogleFonts.aBeeZee(fontSize: 13),
                                cursorColor: Colors.purple,
                                autocorrect: true,
                                canRequestFocus: true,
                                controller: courseNameController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    label: Text(
                                      "type here..",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.blueGrey, fontSize: 12),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Your Email",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blueGrey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: width > 500 ? 400 : width - 100,
                              child: TextField(
                                style: GoogleFonts.aBeeZee(fontSize: 13),
                                cursorColor: Colors.purple,
                                autocorrect: true,
                                canRequestFocus: true,
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    label: Text(
                                      "enter valid email..",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.blueGrey, fontSize: 12),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Your Mobile Number",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blueGrey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: width > 500 ? 400 : width - 100,
                              child: TextField(
                                style: GoogleFonts.aBeeZee(fontSize: 13),
                                cursorColor: Colors.purple,
                                autocorrect: true,
                                canRequestFocus: true,
                                keyboardType: TextInputType.phone,
                                controller: mobileNumberController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    label: Text(
                                      "Enter valid mobile number..",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.blueGrey, fontSize: 12),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Short Description about Your Academic",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.blueGrey, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              width: width > 500 ? 400 : width - 40,
                              child: RawKeyboardListener(
                                focusNode: FocusNode(),
                                onKey: (RawKeyEvent event) {
                                  if (event is RawKeyDownEvent &&
                                      event.isShiftPressed &&
                                      event.logicalKey ==
                                          LogicalKeyboardKey.enter) {
                                    shortDescriptionAboutYouController.text +=
                                        '\n';
                                  }
                                },
                                child: TextField(
                                  style: GoogleFonts.aBeeZee(fontSize: 13),
                                  cursorColor: Colors.purple,
                                  autocorrect: true,
                                  canRequestFocus: true,
                                  maxLines: null,
                                  textInputAction: TextInputAction.none,
                                  keyboardType: TextInputType.multiline,
                                  controller:
                                      shortDescriptionAboutYouController,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)))),
                                  // onSubmitted: (value) {
                                  //   _sendMessage(_messageController.text, '');
                                  // },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            FloatingActionButton.extended(
                                extendedPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 0),
                                splashColor:
                                    const Color.fromARGB(200, 163, 219, 244),
                                hoverColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(198, 198, 209, 232),
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    submitApplication(context);
                                  } else {
                                    showMessage(context, "Please Sign In");
                                  }
                                },
                                label: Text("Submit Application",
                                    style: GoogleFonts.aBeeZee(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  submitApplication(BuildContext context) {
    final String volunteerName = nameController.text;
    final String instituteName = instituteNameController.text;
    final String courseName = courseNameController.text;
    final String email = emailController.text;
    final String mobileNumber = mobileNumberController.text;
    final String shortDescription = shortDescriptionAboutYouController.text;
    final DateTime dateTime = DateTime.now();

    DocumentReference volunteerApplication = FirebaseFirestore.instance
        .collection('FirstVolunteerBatchApplication')
        .doc(userEmail);
    if (volunteerName.isEmpty ||
        instituteName.isEmpty ||
        courseName.isEmpty ||
        email.isEmpty ||
        mobileNumber.isEmpty ||
        shortDescription.isEmpty) {
      return showMessage(context, "all fields are required");
    } else if (userEmail == null) {
      return showMessage(context, "Please SignIn");
    } else {
      // 2023 : year, VB : Volunteer Batch 1,
      Map<String, dynamic> data = {
        'date': dateTime,
        'volunteerName': volunteerName,
        'instituteName': instituteName,
        'courseName': courseName,
        'email': email,
        'mobileNumber': mobileNumber,
        'shortDescription': shortDescription,
      };

      // Upload the data to the Firestore document
      volunteerApplication.set(data).then((value) {
        nameController.clear();
        instituteNameController.clear();
        courseNameController.clear();
        emailController.clear();
        mobileNumberController.clear();
        shortDescriptionAboutYouController.clear();
      }).catchError((error) {
        return showMessage(context, "Submission Failed, Please Try Again");
      });
      return showDialog(
          context: context,
          builder: (context) => Dialog(
                alignment: Alignment.bottomRight,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    """
        Thank You ! $volunteerName
                
Your Application has been Submitted, Successfully...

Once 108 Team reviews your application, 

we will inform you through your email : $email

""",
                    style:
                        GoogleFonts.aBeeZee(fontSize: 14, color: Colors.blue),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
    }
  }

  showMessage(BuildContext context, String s) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              alignment: Alignment.bottomRight,
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  s,
                  style: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ));
  }
}
