import 'package:fikkton/ui/admin/posts_page.dart';
import 'package:fikkton/ui/landing_page_component/homepage/widgets/navigation_helper.dart';
import 'package:fikkton/ui/admin/new_post.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../widgets/custom_button_nav.dart/custom_button_nav.dart';
import 'announcement_page.dart';
import 'dashboard.dart';
import 'notifications.dart'; 

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  final List<Widget> _pages = [
    const Dashboard(),
    const Posts(),
    const AnnouncementsPage(),
   const Notifications(),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          heroTag: "Add",
          elevation: 10,
          backgroundColor: AppColors.lightSecondary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(color: AppColors.lightSecondary)),
          splashColor: AppColors.lightSecondary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            NavigationHelper.navigateToPage(context, const NewPost(isUpdate: false, postId: '',));
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppColors.cardColor, blurRadius: 14, spreadRadius: 6),
          ],
        ),
        child: FABBottomAppBar(
          height: 100,
          onTabSelected: _onItemTapped,
          color: Colors.black87,
          selectedIconHeight: 25,
          iconHeight: 24,
          selectedColor: AppColors.lightSecondary,
          backgroundColor: AppColors.cardColor,
          notchedShape: const CircularNotchedRectangle(),
          selectedFontSize: 12,
          items: [
            FABBottomAppBarItem(
              label: 'Home',
              icon: AppImages.dashboardOutline,
              selectedIcon: AppImages.dashboard,
            ),
            FABBottomAppBarItem(
              label: 'Posts',
              icon: AppImages.articleOutline,
              selectedIcon: AppImages.article,
            ),
            FABBottomAppBarItem(
              label: 'Announce',
              icon: AppImages.campaignOutline,
              selectedIcon: AppImages.campaign,
            ),
            FABBottomAppBarItem(
              label: 'Notify',
              icon: AppImages.notificationsOutline,
              selectedIcon: AppImages.notifications,
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
