import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'crudOperationOnProfile.dart';

class ProfilePage1 extends StatefulWidget {
  final user = FirebaseAuth.instance.currentUser!;
  ProfilePage1({Key? key}) : super(key: key);

  @override
  State<ProfilePage1> createState() => _ProfilePage1State(user);
}

class _ProfilePage1State extends State<ProfilePage1> {
  shareContent(BuildContext context) async {
    await Share.share('''
Dear ${myprofile['username'].toString().toUpperCase()},

Welcome to the Society of Humanity Education and Research's volunteer community!

Your decision to join us on the 'TOP 108 Companies Updates' platform is truly appreciated. We are excited to have someone as dedicated and passionate as you contributing to the empowerment of employment for the betterment of society.

As a volunteer, you play a crucial role in our collective effort to unlock opportunities, promote growth in society, and make a positive impact on individuals' lives.

Thank you for choosing to be a part of this journey. 

Once again, welcome to our community!

Best regards,
Society of Humanity Education and Research Team

🚀 https://top108.web.app/ 🚀
''',
        subject:
            "Welcome to the Society of Humanity Education and Research Volunteer Community!",
        sharePositionOrigin:
            Rect.fromCenter(center: Offset.zero, width: 30, height: 20));
  }

  final User user;
  var myprofile = {
    'username': '',
    'isAmbasdor': 0,
    'affiliatedTo': '',
    'urlLink': '',
  };

  _ProfilePage1State(this.user);

  @override
  void initState() {
    super.initState();
    fetchUserProfileData();
  }

  Future<void> fetchUserProfileData() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('publicUsers')
          .doc(user.email)
          .get();

      setState(() {
        myprofile['username'] = snapshot['username'];
        myprofile['affiliatedTo'] = snapshot['affiliatedTo'];
        myprofile['isAmbasdor'] = snapshot['isAmbasdor'];
        myprofile['urlLink'] = snapshot['urlLink'];
      });
    } catch (e) {
      const CircularProgressIndicator(
        color: Colors.green,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: _TopPortion(user.email!.toLowerCase())),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Center(
                      child: Text(
                        myprofile['username'].toString(),
                        style: GoogleFonts.abhayaLibre(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FloatingActionButton.extended(
                        onPressed: () {},
                        elevation: 3,
                        backgroundColor: Colors.black,
                        splashColor: Colors.purple,
                        label: Text(
                          myprofile['affiliatedTo'].toString(),
                          style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        )),
                    const SizedBox(height: 16),
                    Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () => crudOperationOnProfile(context),
                              label: const Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.white),
                              ),
                              splashColor: Colors.amberAccent,
                              elevation: 4,
                              backgroundColor: Colors.black38,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            FloatingActionButton.extended(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    });
                                signOut();
                                Navigator.of(context).pop();
                              },
                              heroTag: 'SignOut',
                              elevation: 4,
                              backgroundColor: Colors.black54,
                              label: const Text(
                                "Sign Out",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(Icons.logout),
                            ),
                            const SizedBox(width: 8.0),
                            FloatingActionButton.extended(
                              onPressed: () async => await launchUrl(
                                  Uri.parse(myprofile['urlLink'].toString())),
                              heroTag: 'Linkedin',
                              elevation: 4,
                              backgroundColor: Colors.black54,
                              label: const Text(
                                "Linkedin",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(Icons.link),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (myprofile['isAmbasdor'] == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shield,
                            color: Color.fromARGB(255, 3, 59, 104),
                          ),
                          IconButton(
                              onPressed: () => shareContent(context),
                              icon: const Icon(
                                Icons.share,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                    if (myprofile['isAmbasdor'] == true)
                      Text(
                        "'Society of Humanity Education and Research' proudly acknowledges the dedication of ${myprofile['username'].toString().toUpperCase()} as a volunteer contributing to the empowerment of employment for the societal benefit on the 'TOP 108 Companies Updates' platform.",
                        style: GoogleFonts.alata(
                            color: const Color.fromARGB(255, 1, 4, 155)),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const Center(
    //           child: CircularProgressIndicator(
    //         color: Colors.purple,
    //       ));
    //     });
    await FirebaseAuth.instance.signOut();
    // Navigator.pop(context);
  }
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class _TopPortion extends StatefulWidget {
  final String username;
  const _TopPortion(this.username, {Key? key}) : super(key: key);

  @override
  State<_TopPortion> createState() => _TopPortionState(username);
}

class _TopPortionState extends State<_TopPortion> {
  final String? user_pic = FirebaseAuth.instance.currentUser!.photoURL;

  final String username;

  _TopPortionState(this.username);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xff0000ba), Color(0xf0123000)]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(400),
                    topRight: Radius.circular(500)
                    // bottomRight: Radius.circular(2)
                    )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                      child: user_pic != null
                          ? ProfilePicture(
                              radius: 31,
                              fontsize: 21,
                              img: user_pic!,
                              name: username,
                            )
                          // Image.network(user_pic!, )
                          : ProfilePicture(
                              name: username, radius: 20, fontsize: 76)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                            color: Colors.green, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
