// // main.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// final urlHello = Uri.parse('https://groupchat-1dg2.onrender.com/');
//
// Future<void> _launchUrl() async {
//   if (!await launchUrl(urlHello)) {
//     throw Exception('Could not launch $urlHello');
//   }
// }
//
// class HelloPage extends StatefulWidget {
//   const HelloPage({Key? key}) : super(key: key);
//
//   @override
//   State<HelloPage> createState() => _HelloPageState();
// }
//
// class _HelloPageState extends State<HelloPage> {
//   // text fields' controllers
//   final TextEditingController _discussionSubController =
//       TextEditingController();
//   String _dateTimeController = DateTime.now().toString();
//   final user = FirebaseAuth.instance.currentUser;
//   final _accessToken = {'mentor': "guest"};
//   CollectionReference get _productss =>
//       FirebaseFirestore.instance.collection("Hello_${_accessToken['mentor']}");
//
//   // This function is triggered when the floatting button or one of the edit buttons is pressed
//   // Adding a product if no documentSnapshot is passed
//   // If documentSnapshot != null then update an existing product
//   Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
//     String action = 'create';
//     if (documentSnapshot != null) {
//       action = 'update';
//       _discussionSubController.text = documentSnapshot['discussionSub'];
//       // _dateTimeController = documentSnapshot['dateTime'];
//     }
//
//     await showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext ctx) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 top: 20,
//                 left: 20,
//                 right: 20,
//                 // prevent the soft keyboard from covering text fields
//                 bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: TextField(
//                     controller: _discussionSubController,
//                     decoration:
//                         const InputDecoration(labelText: "Friendly Discussion"),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(action == 'create' ? 'send..' : 'update'),
//                 InkWell(
//                   child: const Icon(Icons.send_outlined),
//                   onTap: () async {
//                     final String discussionSub = _discussionSubController.text;
//                     final String discussionTime =
//                         _dateTimeController.toString();
//
//                     if (action == 'create') {
//                       // Persist a new product to Firestore
//                       await _productss.add({
//                         "discussionSub": discussionSub,
//                         "discussionTime": discussionTime,
//                       });
//                     }
//
//                     if (action == 'update') {
//                       // Update the product
//                       await _productss.doc(documentSnapshot!.id).update({
//                         "discussionSub": discussionSub,
//                         // "discussionTime": discussionTime,
//                       });
//                     }
//
//                     // Clear the text fields
//
//                     setState(() {
//                       _discussionSubController.text = '';
//                       _dateTimeController = DateTime.now().toString();
//                     });
//                     // Hide the bottom sheet
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   // Deleteing a product by id
//   Future<void> _deleteProduct(String productId) async {
//     await _productss.doc(productId).delete();
//
//     // Show a snackbar
//     ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Successfully Deleted a Message')));
//   }
//
//   // bool I_am_mentor = false;
//   @override
//   void initState() {
//
//     super.initState();
//     // is_mentor();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Center(
//       //       child: Text("Notifications",
//       //           style: GoogleFonts.patuaOne(
//       //               textStyle: const TextStyle(color: Colors.black)))),
//       //   backgroundColor: Colors.amber,
//       // ),
//       // Using StreamBuilder to display all products from Firestore in real-time
//       body: StreamBuilder(
//         stream: _productss.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//           if (streamSnapshot.hasData) {
//             return ListView.builder(
//               itemCount: streamSnapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 final DocumentSnapshot documentSnapshot =
//                     streamSnapshot.data!.docs[index];
//                 return Card(
//                   margin: const EdgeInsets.all(10),
//                   child: ListTile(
//                     title: Text(documentSnapshot['discussionSub'],
//                         style: GoogleFonts.patuaOne(
//                             textStyle: const TextStyle(color: Colors.purple))),
//                     subtitle: Text(documentSnapshot['discussionTime'],
//                         style: GoogleFonts.patuaOne(
//                             textStyle: const TextStyle(
//                                 color: Colors.black38,
//                                 fontWeight: FontWeight.w300))),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           // Press this button to edit a single product
//                           IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () =>
//                                   _createOrUpdate(documentSnapshot)),
//                           // This icon button is used to delete a single product
//                           IconButton(
//                               icon: const Icon(Icons.delete),
//                               onPressed: () =>
//                                   _deleteProduct(documentSnapshot.id)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       // Add new product
//       floatingActionButton: FloatingActionButton.large(
//           onPressed: () {
//             _createOrUpdate();
//             // _launchUrl();
//           },
//           splashColor: Colors.white12,
//           backgroundColor: Colors.white30,
//           child: Text(
//             "Ask",
//             style: GoogleFonts.patuaOne(
//                 textStyle: const TextStyle(color: Colors.white)),
//           )),
//     );
//   }
//
//   // is_mentor() async {
//   //   await FirebaseFirestore.instance
//   //       .collection('mentors')
//   //       .doc(FirebaseAuth.instance.currentUser!.email)
//   //       .get()
//   //       .then((value) {
//   //     if (value.exists) {
//   //       setState(() {
//   //         I_am_mentor = true;
//   //       });
//   //     } else {
//   //       setState(() {
//   //         I_am_mentor = false;
//   //       });
//   //     }
//   //   });
//   // }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;
  var _accessToken = {'mentor': 'Global'};

  Future<void> _giveAccessToken() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('publicUsers')
          .doc(user!.email)
          .get();

      if (snapshot.exists) {
        setState(() {
          _accessToken =
              (snapshot.data() as Map<String, dynamic>).cast<String, String>();
        });
      } else {
        setState(() {
          _accessToken = {'mentor': 'Global'};
        });
      }
    } catch (e) {
      setState(() {
        _accessToken = {'mentor': 'Global'};
      });
    }
  }

  // //Adprovider
  // BannerAd? _bannerAd;
  // bool _isLoaded = false;

  //  replace this test ad unit with your own ad unit.
  // final adUnitId =
  //     Platform.isWindows ? "ca-app-pub-8356711992647862/8180753362" : '';

  // /// Loads a banner ad.
  // void loadAd() async {
  //   _bannerAd = BannerAd(
  //     adUnitId: adUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           _isLoaded = true;
  //         });
  //       },
  //       onAdClosed: (ad) {
  //         ad.dispose();
  //         setState(() {
  //           _isLoaded = false;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, err) {
  //         // Dispose the ad here to free resources.
  //         ad.dispose();
  //       },
  //     ),
  //   );

  //   await _bannerAd!.load();
  // }

  @override
  void initState() {
    super.initState();
    // _giveAccessToken();
    // loadAd();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    // setState(() => _isLoaded = false);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _sendMessage(String message, String imageUrl) async {
    if (message == "\n" || message == " ") {
      return;
    }
    try {
      FirebaseFirestore.instance
          .collection('messages_${_accessToken['mentor']}')
          .add({
        'message': message,
        'imageUrl': imageUrl,
        'timestamp': DateTime.now(),
        'senderId': user!.email, // Replace with your own sender ID
      });
      _messageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Sending Message Failed.."),
        ),
      );
      // Handle the error appropriately
    }
  }

  Future<String> _uploadImageToFirebase(File image) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("sending. . . "),
      ),
    );
    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('chat_images/${DateTime.now()}.png');
      final UploadTask uploadTask = storageReference.putFile(image);
      final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() {});
      return downloadUrl.ref.getDownloadURL();
    } catch (e) {
      return 'Sending Image Failed. . .';
    }
  }

  Future<String> _deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('messages_${_accessToken['mentor']}')
          .doc(messageId)
          .delete();
    } catch (e) {
      return 'Deletion Failed';
    }
    return 'one message deleted';
  }

  ScrollController _scrollController = ScrollController();

  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('messages_${_accessToken['mentor']}')
          .orderBy('timestamp')
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          // Handle the error appropriately
          return const Center(
            child: Text('Network Error. . .'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
            snapshot.data!.docs;

        return ListView.builder(
          controller: _scrollController,
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final message = documents[index].data();
            final messageId = documents[index].id;
            final bool isMyMessage = message['senderId'] ==
                user!.email; // Replace with your own sender ID

            return Dismissible(
              resizeDuration: const Duration(milliseconds: 500),
              key: Key(messageId),
              confirmDismiss: (DismissDirection direction) async {
                if (isMyMessage) {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Deletion"),
                        content: const Text(
                            "Are you sure you want to delete this message?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Delete"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                }
                return false; // Disallow dismissal for non-matching messages
              },
              onDismissed: (direction) {
                _deleteMessage(messageId).toString();
                warningMessage(context, "one message deleted");
              },
              child: Align(
                alignment:
                    isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 14.0),
                  // padding: const EdgeInsets.all(1.0),
                  // decoration: BoxDecoration(
                  //   color: isMyMessage ? Colors.blueAccent[100] : Colors.white,
                  //   borderRadius: BorderRadius.circular(1.0),
                  // ),
                  child:
                      (message['imageUrl'] == null || message['imageUrl'] == "")
                          ? Column(
                              mainAxisAlignment: isMyMessage
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: isMyMessage
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                FloatingActionButton.small(
                                  backgroundColor: Colors.white,
                                  shape: const CircleBorder(eccentricity: 1),
                                  onPressed: () {},
                                  child: Text(message['senderId']
                                      .toString()
                                      .toUpperCase()[0]),
                                ),
                                Text(message['message'],
                                    style: TextStyle(
                                        color: isMyMessage
                                            ? Colors.purple
                                            : Colors.black)),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: isMyMessage
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              crossAxisAlignment: isMyMessage
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                FloatingActionButton.small(
                                  backgroundColor: Colors.white,
                                  shape: const CircleBorder(eccentricity: 1),
                                  onPressed: () {},
                                  child: Text(message['senderId']
                                      .toString()
                                      .toUpperCase()[0]),
                                ),
                                Image.network(message['imageUrl']),
                              ],
                            ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Show the ad only when it is loaded
            // _isLoaded
            //     ? Align(
            //         alignment: Alignment.bottomCenter,
            //         child: SafeArea(
            //           child: Container(
            //             decoration: BoxDecoration(
            //                 border: Border.all(
            //                   color: Colors.pink,
            //                   style: BorderStyle.solid,
            //                   width: 2.0,
            //                 ),
            //                 borderRadius: BorderRadius.circular(15)),
            //             width: _bannerAd!.size.width.toDouble(),
            //             height: _bannerAd!.size.height.toDouble(),
            //             child: AdWidget(ad: _bannerAd!),
            //           ),
            //         ),
            //       )
            //     : const SizedBox(
            //         height: 5,
            // ),

            Expanded(
              child: _buildMessageList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyDownEvent &&
                            event.isShiftPressed &&
                            event.logicalKey == LogicalKeyboardKey.enter) {
                          _messageController.text += '\n';
                        } else if (!event.isShiftPressed &&
                            event.logicalKey == LogicalKeyboardKey.enter) {
                          if (_messageController.text != "\n" &&
                              _messageController.text != '') {
                            _sendMessage(_messageController.text, '');
                          }
                          setState(() {
                            _messageController.text = '';
                          });
                          _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                      child: TextField(
                        autocorrect: true,
                        autofocus: true,

                        maxLines: null,
                        textInputAction: TextInputAction.none,
                        keyboardType: TextInputType.multiline,
                        controller: _messageController,
                        decoration: InputDecoration(
                          suffixIconColor: Colors.pinkAccent,
                          hoverColor: Colors.amberAccent,
                          focusColor: Colors.purple,
                          prefixIconColor: Colors.blue,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Type a message...',
                        ),
                        // onSubmitted: (value) {
                        //   _sendMessage(_messageController.text, '');
                        // },
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: () => warningMessage(context, "disabled"),
                    // onPressed: _pickImageFromGallery,
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      String imageUrl = '';
                      if (_image != null) {
                        imageUrl = _uploadImageToFirebase(_image!).toString();
                        if (imageUrl == '') warningMessage(context, imageUrl);
                      }
                      _sendMessage(_messageController.text, imageUrl);
                      setState(() {
                        _messageController.text = '';
                      });
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );

                      setState(() {
                        _image = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void warningMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
