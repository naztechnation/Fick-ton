import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../../../model/posts/get_posts.dart';

class DraftItems extends StatelessWidget {
  final Posts posts;

  const DraftItems({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: SizedBox(
                        height: 120,
                        width: 130,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: ImageView.network(
                              posts.thumbnail,
                              height: 120,
                              placeholder: AppImages.logo,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      height: 120,
                      width: 130,
                      color: Colors.black26,
                    ),
                  ),
                    const Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Align(
                    alignment: Alignment.center,
                    child: ImageView.svg(
                      AppImages.play,
                      height: 35,
                    )),
              )
                ],
              )),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posts.genre ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                const SizedBox(height: 12.0),
                Text(
                  posts.title ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      posts.createdAt ?? "",
                    ),
                    const SizedBox(width: 8.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageView.svg(
                          AppImages.edit,
                          height: 20,
                        ),
                        SizedBox(width: 8.0),
                        ImageView.asset(
                          AppImages.delete,
                          width: 25,
                          height: 25,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8.0),
                        ImageView.asset(
                          AppImages.upload,
                          width: 20,
                          height: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
