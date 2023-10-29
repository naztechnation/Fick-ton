import 'package:fikkton/extentions/custom_string_extension.dart';
import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/posts/get_posts.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../utils/navigator/page_navigator.dart';
import '../../../admin/new_post.dart';
import '../../../widgets/modals.dart';
import '../movie_details_page.dart';
import 'navigation_helper.dart';

class PublishedItems extends StatelessWidget {

 final Function onTap;
 final Posts posts;
  const PublishedItems({super.key, required this.posts, required this.onTap});

  @override
  Widget build(BuildContext context) {

    final timeFormat = Provider.of<UserViewModel>(context, listen: true);

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
          GestureDetector(
            onTap: (){
               AppNavigator.pushAndStackPage(context,
                        page:   MovieDetailsScreen(videoLinks: posts.videoLink!, postId: posts.id!,));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child:   Stack(
                  children: [
                    ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                child: SizedBox(
                      height: 120,
                      width: 130,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                              child: ImageView.network(posts.thumbnail, height: 120, placeholder: AppImages.logo,fit: BoxFit.cover,))),
                  ),
                  ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                child: Container(height: 120,
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
          ),
          const SizedBox(width: 16.0),
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posts.genre.toString().capitalizeFirstOfEach ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                const SizedBox(height: 12.0),
                Text(
                  posts.title.toString().capitalizeFirstOfEach ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                    timeFormat.getCurrentTime(int.parse(posts.createdAt!)),
                    ),
                    const SizedBox(width: 8.0),
                      Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            NavigationHelper.navigateToPage(context, NewPost(isUpdate: true, postId: posts.id!,));
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: ImageView.svg(
                              AppImages.edit,
                              height: 20,
                            ),
                          ),
                        ),
                          GestureDetector(
                            onTap: (){
                              Modals.showAlertOptionDialog(context, title: 'Delete Post', message: 'Are you sure you want to delete this post. This cannot be Undone.', callback: (){onTap();});
                            },
                            child: const ImageView.asset(
                            AppImages.delete,
                            width: 25,
                            height: 25,
                            color: Colors.red,
                                                  ),
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
