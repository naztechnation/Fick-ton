
import 'package:flutter/material.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_images.dart';
import '../../widgets/image_view.dart';

class NotificationsDetails extends StatelessWidget {
  const NotificationsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(children: [
          SafeArea(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.04,
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
                    const SizedBox(width: 30,),
                     const Text(
                            "Notification",
                            style: TextStyle(fontSize: 18),
                          ),
                  ],
                ),
                const SizedBox(height: 40,),
          Expanded(child:
         SingleChildScrollView(child: Column(children: [
          Container(
                              decoration:   BoxDecoration(
                                color:   AppColors.lightSecondary.withOpacity(0.1) ,
                                border:   Border(bottom: BorderSide(color: Colors.grey.shade300))),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
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
                            )
         ],),))]),
      ),
    );
  }
}