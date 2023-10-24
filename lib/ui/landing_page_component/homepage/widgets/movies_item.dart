

import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../model/posts/get_posts.dart';

class MoviesItems extends StatelessWidget {
 final  Posts posts ;
    const MoviesItems({super.key, required this.posts});
    

  @override
  Widget build(BuildContext context) {


    int minutes = (int.parse(posts.createdAt!) / 60000).round();
    final ago =   DateTime.now().subtract(  Duration(minutes: minutes));
    return  Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child:   Row(
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
                            child: ImageView.network(posts.thumbnail, height: 120, placeholder: AppImages.logo,fit: BoxFit.cover,))),
                ),
                //  
              ],
            ), 
            const SizedBox(width: 16.0),
              Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   posts.genre!,
                   style:const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  ),
            const SizedBox(height: 12.0),

                    Text(
                   posts.title!,
                   style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
            const SizedBox(height: 16.0),
                 
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                   timeago.format(
                          ago,
                          
                        ),
                  ),
                      const SizedBox(width: 8.0),
                        Padding(
                         padding: const EdgeInsets.only(right:12.0),
                         child: ImageView.svg(  posts.isBooked  == '0' ?  AppImages.bookmarkOutline : AppImages.bookmark, height: 25,),
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



// my_custom_messages.dart
