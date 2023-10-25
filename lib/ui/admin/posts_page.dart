import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/admin/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/view_models/user_view_model.dart';
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

    return   DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Fik-kton',
          tabBar: TabBar(
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



