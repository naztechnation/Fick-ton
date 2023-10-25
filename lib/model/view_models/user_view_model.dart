
import 'dart:io';

import 'package:fikkton/model/posts/get_posts.dart' as get_posts;
import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  ImagePicker picker = ImagePicker();

  File? imageURl;

    List<get_posts.Posts> _postsList = [];


   Future<void> setPostLists({required get_posts.GetAllPosts posts}) async {
    _postsList = posts.data ?? [];
    setViewState(ViewState.success);
  }


  loadImage(BuildContext context) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w400)),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  size: 25.0,
                                    color: Colors.grey,

                ),
                title: const Text('Camera', style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w400)),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  imageURl = File(image!.path);
                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo,
                  size: 25.0,
                  color: Colors.grey,
                ),
                title: const Text('Gallery',style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w400)),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  imageURl = File(image!.path);
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }

  File? get imgURl => imageURl;

  List<get_posts.Posts> get postsList => _postsList;


  List<get_posts.Posts> get posts =>
      _postsList.where((p) => p.isTrending == '1').toList();
}
