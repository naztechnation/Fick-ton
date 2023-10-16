import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/widgets/button_view.dart';
import 'package:fikkton/ui/widgets/image_picker.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  bool? isChecked = false; // Initialize the checkbox state.

  void _toggleCheckbox(bool? value) {
    setState(() {
      isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageView.svg(
                        AppImages.logo,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Fik-kton',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  const Align(
                    child: Text(
                      'New Post',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Add Cover Image",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CoverImageContainer(),
                  const SizedBox(
                    height: 20,
                  ),
                  //video url
                  const Text(
                    "Video URL",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextEditView(
                    borderRadius: 16,
                    controller: TextEditingController(text: ''),
                    isDense: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  //title
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Title",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextEditView(
                    borderRadius: 16,
                    controller: TextEditingController(text: ''),
                    isDense: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  //article
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Article",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextEditView(
                    maxLines: 20,
                    hintText: 'Start writing your article here...',
                    borderRadius: 16,
                    controller: TextEditingController(text: ''),
                    isDense: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Type",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextEditView(
                    onChanged: (value) {},
                    readOnly: true,
                    hintText: 'Select Category',
                    borderRadius: 16,
                    controller: TextEditingController(text: ''),
                    isDense: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Genres",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextEditView(
                    onChanged: (value) {},
                    readOnly: true,
                    hintText: 'Select Genres',
                    borderRadius: 16,
                    controller: TextEditingController(text: ''),
                    isDense: true,
                    fillColor: Colors.grey.shade200,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        fillColor: const MaterialStatePropertyAll(
                            AppColors.lightPrimary),
                        value: isChecked,
                        onChanged: _toggleCheckbox,
                      ),
                      const Text(
                        "Make it Trending",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ButtonView(
                    onPressed: () {},
                    color: AppColors.lightPrimary,
                    child: const Text('Publish'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ButtonView(
                    onPressed: () {},
                    color: Colors.white,
                    borderColor: AppColors.lightPrimary,
                    child: const Text(
                      'Save to Draft',
                      style: TextStyle(color: AppColors.lightPrimary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
