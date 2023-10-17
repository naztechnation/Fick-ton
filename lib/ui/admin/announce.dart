import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/admin/widget/custom_appbar.dart';
import 'package:fikkton/ui/admin/widget/annonce_tile.dart';
import 'package:flutter/material.dart';

class Announce extends StatefulWidget {
  const Announce({super.key});

  @override
  State<Announce> createState() => _AnnounceState();
}

class _AnnounceState extends State<Announce> {
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
                text: 'All Users(3750)',
              ),
              Tab(
                text: 'Other Users',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AllUsers(),
            OtherUsers(),
          ],
        ),
      ),
    );
  }
}

//All Users
class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return AllUsersTile();
  }
}

//Other users
class OtherUsers extends StatelessWidget {
  const OtherUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return OtherUsersTile();
  }
}
