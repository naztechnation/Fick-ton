import 'dart:io';

import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';

 


class CoverImageContainer1 extends StatefulWidget {
  @override
  _CoverImageContainerState createState() => _CoverImageContainerState();
}

class _CoverImageContainerState extends State<CoverImageContainer1> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

    return GestureDetector(
      onTap: () {
        
        user.loadImage1(context);
      },
      child: Container(
        height: 175,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: user.imageURl1 == null
              ? Border.all(
                  width: 1,
                  color:
                      Colors.grey)
              : null, 
        ),
        child: user.imageURl1 != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(user.imageURl1?.path ?? ''),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : const Center(
                child: ImageView.asset(
                  AppImages.galleryAdd,
                  color: Colors.grey,
                  width: 60,
                  height: 60,
                ),
              ),
      ),
    );
  }
}


class CoverImageContainer2 extends StatefulWidget {
  @override
  _CoverImageContainer2State createState() => _CoverImageContainer2State();
}

class _CoverImageContainer2State extends State<CoverImageContainer2> {


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

    return GestureDetector(
      onTap: () {
        
        user.loadImage2(context);
      },
      child: Container(
        height: 175,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: user.imageURl2 == null
              ? Border.all(
                  width: 1,
                  color:
                      Colors.grey)
              : null, 
        ),
        child: user.imageURl2 != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(user.imageURl2?.path ?? ''),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            : const Center(
                child: ImageView.asset(
                  AppImages.galleryAdd,
                  color: Colors.grey,
                  width: 60,
                  height: 60,
                ),
              ),
      ),
    );
  }
}
