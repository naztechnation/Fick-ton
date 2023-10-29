import 'package:fikkton/model/posts/get_posts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/view_models/user_view_model.dart';
import '../../../res/app_images.dart';
import '../../widgets/image_view.dart';

class DetailsPage extends StatelessWidget {
  final Pinned pinned;

  DetailsPage({required this.pinned});

  @override
  Widget build(BuildContext context) {
    final timeFormat = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: ImageView.svg(
                      AppImages.arrowBack,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const ImageView.asset(
                  AppImages.logo,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  width: 12,
                ),
                const Text(
                  "Fik-kton",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Announcement",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: pinned.thumbnail ?? '',
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ImageView.network(
                          pinned.thumbnail ?? '',
                          fit: BoxFit.cover,
                          width: MediaQuery.sizeOf(context).width,
                          placeholder: AppImages.logo1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(pinned.content ?? '',
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16)),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                              timeFormat
                                  .getCurrentTime(int.parse(pinned.createdAt!)),
                              style: TextStyle(fontSize: 14)),
                        ),
                      ],
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
