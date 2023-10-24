

import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../../../model/posts/get_posts.dart';

class MoviesItems extends StatelessWidget {
 final  Posts posts ;
    const MoviesItems({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
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
            ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
              child: const Stack(
                children: [
                  ImageView.asset(AppImages.avengers, height: 120,),
                  //  
                ],
              )), 
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
                   posts.createdAt!,
                  ),
                      const SizedBox(width: 8.0),
                       const Padding(
                         padding: EdgeInsets.only(right:12.0),
                         child: ImageView.svg(AppImages.bookmarkOutline, height: 25,),
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