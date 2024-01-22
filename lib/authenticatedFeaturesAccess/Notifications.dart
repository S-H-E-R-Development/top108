import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_selector/file_selector.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:universal_io/io.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final picker = ImagePicker();
  CollectionReference advertizement_ =
      FirebaseFirestore.instance.collection("bigBannerAd");

  _uploadImage(BuildContext context) async {
    if (Platform.isWindows) {
      try {
        const XTypeGroup typeGroup = XTypeGroup(
          label: 'images',
          extensions: <String>['jpg', 'png'],
        );
        final XFile? pickedFile =
            await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
        if (pickedFile != null) {
          final fileAsByte = await pickedFile.readAsBytes();

          final storageReference = FirebaseStorage.instance
              .ref()
              .child('images/${DateTime.now()}.png');

          final UploadTask uploadTask = storageReference.putData(fileAsByte);

          await uploadTask.whenComplete(() {});

          // Get the download URL after the upload is complete
          final downloadURL = await storageReference.getDownloadURL();

          // Add file metadata to Firestore
          await advertizement_.add({
            'downloadURL': downloadURL,
            'fileName': storageReference.name,
            'timestamp': DateTime.now(),
          });

          showDialog(
            context: context,
            builder: (context) {
              return Center(
                  child:
                      Text("Successfully uploaded: ${storageReference.name}"));
            },
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return Center(child: Text(e.toString()));
          },
        );
      }
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      try {
        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final storageReference = FirebaseStorage.instance
              .ref()
              .child('images/${DateTime.now()}.png');

          await storageReference.putFile(file);
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) {
            return Center(child: Text(e.toString()));
          },
        );
      }
    }
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Center(child: Text("SuccessFully uploaded $url"));
    //   },
    // );
  }

  // Create a variable to store the data
  List<Map<String, dynamic>> allData = [
    {
      'downloadURL': 'assets/SHER_logo.png',
      'fileName': 'Society of Humanity Education and Research',
      'timestamp': null,
    },
    {
      'downloadURL': 'assets/icon-512.png',
      'fileName': 'Click To Apply for internship',
      'timestamp': null,
    },
    {
      'downloadURL': 'assets/MS_Dark.png',
      'fileName': 'Society of Humanity Education & Research',
      'timestamp': null,
    }
  ];
  @override
  void initState() {
    super.initState();
    // fetchDataFromFirestore();
    startAnimation();
  }

  fetchDataFromFirestore() async {
    final querySnapshot = await advertizement_.get();
    for (var doc in querySnapshot.docs) {
      final ad = doc.data() as Map<String, dynamic>;
      if (ad['downloadURL'] != null) {
        final imageUrl = ad['downloadURL'];
        final response = await http.get(Uri.parse(imageUrl));

        if (response.statusCode == 200) {
          final byteData = response.bodyBytes;

          setState(() {
            allData.add({
              'downloadURL': byteData,
              'fileName': ad['fileName'],
              'timestamp': ad['timestamp'],
            });
          });
        } else {
          setState(() {
            allData.add({
              'downloadURL': null,
              'fileName': null,
              'timestamp': null,
            });
          });
        }
      } else {
        setState(() {
          allData.add({
            'downloadURL': null,
            'fileName': null,
            'timestamp': null,
          });
        });
      }
    }
  }

  int bannerAdIdx = 0;

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        bannerAdIdx = (bannerAdIdx + 1);
      });
      startAnimation();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            width > 800
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 2 * width / 3,
                          // decoration: BoxDecoration(
                          //   image: allData[bannerAdIdx % allData.length]
                          //               ['downloadURL'] ==
                          //           null
                          //       ? const DecorationImage(
                          //           image: AssetImage("assets/SHER_LOGO.png"),
                          //           fit: BoxFit.fitHeight)
                          //       : ,
                          // ),
                          height: height / 3,
                          child: Center(
                            child: Stack(
                              children: [
                                allData[bannerAdIdx % allData.length]
                                            ['downloadURL'] ==
                                        null
                                    ? const Image(
                                        image:
                                            AssetImage("assets/SHER_LOGO.png"))
                                    // : Image.memory(
                                    //     Uint8List.fromList(allData[bannerAdIdx %
                                    //         allData.length]['downloadURL']),
                                    //     fit: BoxFit.fitHeight,
                                    //   ),
                                    : Image(
                                        image: AssetImage(allData[(bannerAdIdx +
                                                1) %
                                            allData.length]['downloadURL'])),
                                Column(
                                  children: [
                                    FloatingActionButton.extended(
                                        splashColor: const Color.fromARGB(
                                            200, 163, 219, 244),
                                        hoverColor: Colors.white,
                                        backgroundColor: const Color.fromARGB(
                                            80, 109, 128, 238),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "About the Poster")));
                                        },
                                        label: Text(
                                          "Read More | ${allData[(bannerAdIdx + 1) % allData.length]['fileName']}",
                                          style: GoogleFonts.akayaTelivigala(
                                              letterSpacing: 2),
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    FloatingActionButton.small(
                                        tooltip:
                                            'make your post visible globally',
                                        onPressed: () {
                                          displayMessage(context,
                                              "Advertizing feature is disable now,     you may write us at - top108compinternship@gmail.com");
                                          Clipboard.setData(const ClipboardData(
                                              text:
                                                  'top108compinternship@gmail.com'));
                                          displayMessage(
                                              context, 'email copied');

                                          // _uploadImage(context);
                                        },
                                        backgroundColor:
                                            const Color.fromARGB(56, 0, 0, 0),
                                        splashColor: const Color.fromARGB(
                                            69, 64, 195, 255),
                                        hoverColor: const Color.fromARGB(
                                            255, 217, 232, 240),
                                        child: const Icon(
                                          Icons.add_circle_outline_rounded,
                                          semanticLabel:
                                              'make your post visible globally',
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: width / 3,
                            height: height / 6,
                            child: allData[bannerAdIdx % allData.length]
                                        ['downloadURL'] !=
                                    null
                                ?
                                // ? Center(
                                //     child: Image.network(
                                //       allData[bannerAdIdx % allData.length]
                                //           ['downloadURL'],
                                //       fit: BoxFit.fitHeight,
                                //     ),
                                //   )
                                Image(
                                    image: AssetImage(
                                        allData[bannerAdIdx % allData.length]
                                            ['downloadURL']))
                                : Image(
                                    image: AssetImage(allData[
                                            (bannerAdIdx + 1) % allData.length]
                                        ['downloadURL'])),
                          ),
                          SizedBox(
                              width: width / 3,
                              height: height / 6,
                              child: Image(
                                  image: AssetImage(allData[(bannerAdIdx + 2) %
                                      allData.length]['downloadURL']))),
                          // adsenseWidget(context)
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      allData[(bannerAdIdx) % allData.length]
                                          ['downloadURL']),
                                  fit: BoxFit.contain)),
                          height: height / 3,
                          child: Center(
                            child: Column(
                              children: [
                                FloatingActionButton.extended(
                                    splashColor: Colors.lightBlueAccent,
                                    hoverColor: Colors.white,
                                    backgroundColor:
                                        const Color.fromARGB(99, 95, 197, 252),
                                    onPressed: () {},
                                    label: Text(
                                      "Read More | ${allData[(bannerAdIdx) % allData.length]['fileName']}",
                                      style: GoogleFonts.akayaTelivigala(
                                          letterSpacing: 2),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                FloatingActionButton.small(
                                    tooltip: 'make your post visible globally',
                                    onPressed: () {
                                      displayMessage(context,
                                          "Advertising feature is disable now,     you may write us at - top108compinternship@gmail.com");
                                      Clipboard.setData(const ClipboardData(
                                          text:
                                              'top108compinternship@gmail.com'));
                                      displayMessage(context, 'email copied');
                                    },
                                    backgroundColor: const Color.fromARGB(
                                        100, 162, 151, 151),
                                    splashColor: Colors.lightBlueAccent,
                                    hoverColor: const Color.fromARGB(
                                        200, 217, 232, 240),
                                    child: const Icon(
                                      Icons.add_circle_outline_rounded,
                                      semanticLabel:
                                          'make your post visible globally',
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                          )),
                      // Container(
                      //     width: width,
                      //     color: const Color.fromARGB(255, 84, 82, 75),
                      //     height: height / 9,
                      //     child: const Center(child: Text("Second"))),
                      Image(
                        image: AssetImage(
                            allData[(bannerAdIdx + 1) % allData.length]
                                ['downloadURL']),
                        height: height / 3,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

Future<void> displayMessage(BuildContext context, String? message) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color.fromARGB(255, 225, 216, 216),
      content: Center(
        child: Text(
          message!,
          style: const TextStyle(color: Colors.black),
        ),
      )));
}


//name, email, institute name, course,
// name, institute name, course, mobile number, short description about you