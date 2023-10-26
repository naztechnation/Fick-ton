import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../widgets/image_view.dart';
import '../homepage/search_page.dart';
import 'notifications_details.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
bool showother =  false;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
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
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: const SearchPage());
                  },
                  child: const ImageView.svg(
                    AppImages.search,
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 26,
          ),
           GestureDetector(
            onTap: (){
              setState(() {
                      showother = !showother;
                        
                      });
            },
             child: const Padding(
               padding: EdgeInsets.symmetric(horizontal:16.0),
               child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Notifications',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
             ),
           ),
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(children: [
               
                const SizedBox(
                  height: 26,
                ),
                Visibility(
                  visible: showother,
                  child: ListView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: (){
                            AppNavigator.pushAndStackPage(context, page:const NotificationsDetails(title: 'Message', description: 'Content', date: '',));
                          },
                          child: Container(
                            decoration:   BoxDecoration(
                              color: (index % 2 == 0)? AppColors.lightSecondary.withOpacity(0.1) : Colors.white,
                              border:   Border(bottom: BorderSide(color: Colors.grey.shade300))),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Security Updates",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 12.0),
                                  Text(
                                    "Now Fik-kton has a Two-Factor Authentication. Try it now to make your account more secured.",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400, fontSize: 14),
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "17 June, 2023",
                                      ),
                                      SizedBox(width: 15.0),
                                      Padding(
                                        padding: EdgeInsets.only(right: 12.0),
                                        child: Text(
                                          "3 min ago",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Visibility(
                visible: !showother,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                    showother = !showother;
                      
                    });
                    },
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: ImageView.asset(AppImages.empty, height: 160,)),
                        SizedBox(height: 40.0),
                        Text(
                          "Empty",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "You don’t have any notification at this time",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ]),
            ),
          )),
        ],
      ),
    );
  }
}
