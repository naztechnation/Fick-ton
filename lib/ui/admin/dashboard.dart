import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/image_view.dart';
import 'widget/dashboard_container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
            const SingleChildScrollView(
            child: Padding(
                    padding: EdgeInsets.only(left:8.0, right: 8),

              child: Column(
                children: [
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Dashbord',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
             SizedBox(
                    height: 30,
                  ),
               Row(
                 children: [
                   Expanded(
                    
                    child: dashBoardContainer(description: ImageView.svg(AppImages.edit), imageUrl: '', title: 'Create New Post',)),
                   Expanded(
                    
                    child: dashBoardContainer(description: Text('18', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),), imageUrl:AppImages.news, title: 'Total Posts',)),
                 ],
               ),
               SizedBox(
                    height: 5,
                  ),
               Row(
                 children: [
                   Expanded(
                    
                    child: dashBoardContainer(description: Text('3750', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),), imageUrl:AppImages.group , title: 'Total Users',)),
                   Expanded(
                    
                    child: dashBoardContainer(description: Text('11210', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),), imageUrl:AppImages.visibility, title: 'Total Views',)),
                 ],
               )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

 
}
