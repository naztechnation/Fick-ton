import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHandler{

  /// Pick images from gallery or camera
  static Future<dynamic> pickImage(BuildContext context, {bool image=true}) async {
    dynamic  _pickedImage;
    final imageSource = await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(borderRadius:
        BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text(image?'Select the images source':'Select the video source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Camera'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Icon(
                  Icons.photo,
                  size: 35.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: const Text('Gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          );
        });



    if (imageSource != null) {
      final file = (image)
          ? await ImagePicker().pickImage(source: imageSource,
          imageQuality: 80, maxHeight: 1000, maxWidth: 1000)
          : await ImagePicker().pickVideo(source: imageSource,
          maxDuration: const Duration(seconds: 30));

      if (file != null) {
        _pickedImage = file;
      }

    }
    return _pickedImage;
  }


  ///Crop images
  static Future<CroppedFile?> cropImage(File imageFile) async {
    CroppedFile? newImageFile;
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          IOSUiSettings(
            minimumAspectRatio: 1.0,
            title: 'Crop Image',
            aspectRatioLockEnabled: false,
            hidesNavigationBar: true,
            cancelButtonTitle: 'Cancel',
            doneButtonTitle: 'Done',
          ),
        ]
    );
    if (croppedFile != null) {
      newImageFile = croppedFile;
    }

    return newImageFile;
  }

}