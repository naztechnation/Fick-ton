import 'dart:io';

import 'package:fikkton/model/posts/get_posts.dart' as get_posts;
import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  ImagePicker picker = ImagePicker();

  File? imageURl;
  String _draftLength = "0";
  String _publishedLength = "0";
  int _activeTab  = 0;

   get_posts.GetAllPosts? _overallPosts ;
   List<get_posts.Pinned> _pinnedPosts = [];

  List<get_posts.Posts> _postsList = [];
  List<get_posts.Posts> _draftPostsList = [];

  Future<void> setPostLists({required get_posts.GetAllPosts posts}) async {
    _postsList = posts.data?.posts ?? [];
    _overallPosts = posts;
    _pinnedPosts = posts.data?.pinned ?? [];
    setViewState(ViewState.success);
  }

   Future<void> setDraftPostLists({required get_posts.GetAllPosts posts}) async {
    _draftPostsList = posts.data?.posts ?? [];
     setDraftLength(draftedLength: _draftPostsList.length.toString());
    setViewState(ViewState.success);
  }

  Future<void> setPublishedLength({required String publishedLength}) async {
    _publishedLength = publishedLength;
    setViewState(ViewState.success);
  }

  Future<void> setDraftLength({required String draftedLength}) async {
    _draftLength = draftedLength;
    setViewState(ViewState.success);
  }

   Future<void> setTabIndex({required int tabIndex}) async {
    _activeTab = tabIndex;
    setViewState(ViewState.success);
  }

  Future<void> clearImage() async {
    imageURl = null;
    setViewState(ViewState.success);
  }

  Future<File> fileFromImageUrl(String imageUrl, ) async {
    String img = imageUrl;
    final response = await http.get(Uri.parse(img));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final String imageName = imageUrl.split('/').last;
        final file = File('${documentDirectory.path}/$imageName');

        await file.writeAsBytes(response.bodyBytes);

    imageURl = file;
    setViewState(ViewState.success);
    return file;
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
                title: const Text('Camera',
                    style: TextStyle(
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
                title: const Text('Gallery',
                    style: TextStyle(
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


  String getCurrentTime(int timestampInSeconds)   {
     
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);

      String time = formatTimeAgo(date);
    

        setViewState(ViewState.success);


    return time;
  }

 String formatTimeAgo(DateTime inputDate) {
   
    DateTime now = DateTime.now();
  Duration difference = now.difference(inputDate);

  if (difference.inDays >= 3) {
    return DateFormat.yMMMd().format(inputDate);
  } else if (difference.inDays >= 1) {
    if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  } else if (difference.inHours >= 1) {
    if (difference.inHours == 1) {
      return '1 hour ago';
    } else {
      return '${difference.inHours} hours ago';
    }
  } else if (difference.inMinutes >= 1) {
    if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else {
      return '${difference.inMinutes} minutes ago';
    }
  } else {
    return 'Just now'; 
  }
}








  File? get imgURl => imageURl;

  List<get_posts.Posts> get postsList => _postsList;
  List<get_posts.Posts> get draftList => _draftPostsList;
  List<get_posts.Pinned> get pinnedList => _pinnedPosts;
  String get draftedLength => _draftLength;
  int get activeTab => _activeTab;
  String get publishedLength => _publishedLength;

  get_posts.GetAllPosts?  get overallPosts => _overallPosts;

  List<get_posts.Posts> get posts =>
      _postsList.where((p) => p.isTrending == '1').toList();
}
