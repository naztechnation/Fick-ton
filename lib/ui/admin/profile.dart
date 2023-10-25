import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/admin/widget/custom_appbar.dart';
import 'package:fikkton/ui/admin/widget/annonce_tile.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
                text: 'Admin',
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
