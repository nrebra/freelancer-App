import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserImagePicker extends StatefulWidget {
  final Function(String imageUrl) onImagePicked;

  const UserImagePicker({required this.onImagePicked, Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
        source: source, imageQuality: 50, maxWidth: 150);

    if (pickedImage != null) {
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(user.uid + '.jpg');

        await ref.putFile(_pickedImageFile!);
        final url = await ref.getDownloadURL();

        widget.onImagePicked(
            url); // Callback fonksiyonunu çağırırken parametreyi geçirin
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.gallery),
          icon: Icon(Icons.photo_library),
          label: Text('Galeriden Seç'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.orange, // Butonun yazı ve ikon rengi siyah
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.camera),
          icon: Icon(Icons.camera_alt),
          label: Text('Kameradan Çek'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.orange, // Butonun yazı ve ikon rengi siyah
          ),
        ),
      ],
    );
  }
}
