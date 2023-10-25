import 'dart:io';

import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/user_view_model.dart';


class CoverImageContainer extends StatefulWidget {
  @override
  _CoverImageContainerState createState() => _CoverImageContainerState();
}

class _CoverImageContainerState extends State<CoverImageContainer> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

    return GestureDetector(
      onTap: () {
        
        user.loadImage(context);
      },
      child: Container(
        height: 275,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: user.imageURl == null
              ? Border.all(
                  width: 1,
                  color:
                      Colors.grey)
              : null, 
        ),
        child: user.imageURl != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(user.imageURl!.path),
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
