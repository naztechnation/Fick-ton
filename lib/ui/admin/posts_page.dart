import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/admin/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/user_view_model.dart';
import '../../res/app_images.dart';
import '../../utils/navigator/page_navigator.dart';
import '../landing_page_component/homepage/search_page.dart';
import '../widgets/image_view.dart';
import '../widgets/modals.dart';
import 'widget/draft_page.dart';
import 'widget/published_page.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

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
                text: 'Published(${user.publishedLength})',
              ),
              Tab(
                text: 'Draft(${user.draftedLength})',
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

                Modals.showToast('message');
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
            Published(),
            Draft(),
          ],
        ),
      ),
    );
  }
}
