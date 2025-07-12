import 'package:fikkton/extentions/custom_string_extension.dart';
import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/posts/get_posts.dart';
import '../../../../model/view_models/user_view_model.dart';

class MoviesItems extends StatelessWidget {
  final Posts posts;
  const MoviesItems({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    final timeFormat = Provider.of<UserViewModel>(context, listen: false);
    
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
          Stack(
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
                          placeholder: AppImages.logo1,
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
              // const Positioned(
              //   top: 40,
              //   left: 0,
              //   right: 0,
              //   child: Align(
              //       alignment: Alignment.center,
              //       child: ImageView.svg(
              //         AppImages.play,
              //         height: 35,
              //       )),
              // )
            ],
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posts.genre?.capitalizeFirstOfEach ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
                const SizedBox(height: 12.0),
                Text(
                  posts.title?.capitalizeFirstOfEach.
                  toString().replaceAll('&amp;amp;', '')
      .replaceAll('&amp;quot;', '"')
      .replaceAll('\n', '').replaceAll('&amp;', ',') ?? ''  ,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                       timeFormat.getCurrentTime(int.parse(posts.updatedAt ?? '0')),
                    ),
                    const SizedBox(width: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ImageView.svg(
                        posts.isBooked == '0'
                            ? AppImages.bookmarkOutline
                            : AppImages.bookmark,
                        height: 25,
                      ),
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



 
