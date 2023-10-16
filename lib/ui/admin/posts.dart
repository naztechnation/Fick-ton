import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/admin/widget/custom_appbar.dart';
import 'package:fikkton/ui/landing_page_component/homepage/widgets/draft_items.dart';
import 'package:fikkton/ui/landing_page_component/homepage/widgets/published_items.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Fik-kton',
          tabBar: TabBar(
            labelColor: Colors.black,
            indicatorColor: AppColors.lightPrimary,
            tabs: [
              Tab(
                text: 'Published(126)',
              ),
              Tab(
                text: 'Draft(9)',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Published(),
            Draft(),
          ],
        ),
      ),
    );
  }
}

//published
class Published extends StatelessWidget {
  const Published({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 126,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
                onTap: () {
                  // AppNavigator.pushAndStackPage(context,
                  //     page: MovieDetailsScreen());
                },
                child: PublishedItems());
          }),
    );
  }
}

//draft
class Draft extends StatelessWidget {
  const Draft({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 9,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
                onTap: () {
                  // AppNavigator.pushAndStackPage(context,
                  //     page: MovieDetailsScreen());
                },
                child: DraftItems());
          }),
    );
  }
}
