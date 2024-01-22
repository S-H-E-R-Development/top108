import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadAndDisplay extends StatefulWidget {
  const ImageUploadAndDisplay({super.key});

  @override
  _ImageUploadAndDisplayState createState() => _ImageUploadAndDisplayState();
}

class _ImageUploadAndDisplayState extends State<ImageUploadAndDisplay> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _uploadImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');

      await storageReference.putFile(file);
      setState(() {
        _image = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_image != null) Image.file(_image!),
        ElevatedButton(
          onPressed: _uploadImage,
          child: const Text("Upload Image"),
        ),
      ],
    );
  }
}
