import 'dart:io';

import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//pick image function
class CoverImageContainer extends StatefulWidget {
  @override
  _CoverImageContainerState createState() => _CoverImageContainerState();
}

class _CoverImageContainerState extends State<CoverImageContainer> {
  XFile? _imageFile; // Stores the selected image file

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show a dialog to choose between camera and gallery
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Choose Image Source'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.camera),
                      title: const Text('Camera'),
                      onTap: () {
                        _pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('Gallery'),
                      onTap: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: 275,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: _imageFile == null
              ? Border.all(
                  width: 1,
                  color:
                      Colors.grey) // Apply the border when no image is selected
              : null, // No border when an image is selected
        ),
        child: _imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : const Center(
                child: ImageView.asset(
                  AppImages.galleryAdd,
                  color: Colors.grey,
                  width: 80,
                  height: 80,
                ),
              ),
      ),
    );
  }
}
