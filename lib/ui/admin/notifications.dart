import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/admin/widget/custom_appbar.dart';
import 'package:fikkton/ui/admin/widget/annonce_tile.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/image_view.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      
        body:  SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                            children: [
                              ImageView.asset(
                                AppImages.logo,
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Fik-kton',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                const SizedBox(height: 30,),
          
                Padding(
                  padding: EdgeInsets.only(left:12.0),
                  child: Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                ),
                const SizedBox(height: 20,),

                AllUsers(),
              ],
            ),
          ),
        ),
      
    );
  }
}

 
class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return AllUsersTile();
  }
}

 
class OtherUsers extends StatelessWidget {
  const OtherUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherUsersTile();
  }
}
