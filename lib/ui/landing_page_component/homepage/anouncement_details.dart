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
      appBar: AppBar(
        title: Text('Details Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: pinned.thumbnail ?? '',
            child: Container(
              height: 300,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ImageView.network(
                  pinned.thumbnail ?? '',
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                  placeholder: AppImages.logo,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(pinned.content ?? '', style: TextStyle(fontSize: 16)),
                Text(timeFormat.getCurrentTime(int.parse(pinned.createdAt!)),
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
