import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/user_view_model.dart';
import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';
import '../landing_page_component/homepage/search_page.dart';
import '../widgets/image_view.dart';
import 'create_anouncement.dart';
import 'create_message.dart';
 


class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<AnnouncementsPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 50,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: const ImageView.asset(
              AppImages.logo,
              width: 20,
              height: 20,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Fik-kton',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.lightPrimary,
            tabs: [
              Tab(
                text: 'Create Notifications',
              ),
              
              Tab(
                text: 'Create Announcements',
              ),
              
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 35,
              ),
              onPressed: () {

               
                 AppNavigator.pushAndStackPage(context,
                    page: SearchPage(
                      postsLists: user.postsList,
                    ));
              },
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: const TabBarView(
          children: [
            createMessage(),
            CreateAnnouncement(),
             
          ],
        ),
      ),
    );
  }
}
