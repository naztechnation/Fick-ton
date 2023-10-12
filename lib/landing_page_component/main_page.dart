import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../res/app_colors.dart';
import 'homepage/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16))),
        height: 70,
        child: BottomNavigationBar(
          elevation: 12,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? const ImageView.svg(
                      AppImages.home,
                      height: 22,
                    )
                  : const ImageView.svg(
                      AppImages.homeOutline,
                      height: 22,
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? const ImageView.svg(
                      AppImages.bookmark,
                      height: 22,
                    )
                  : const ImageView.svg(
                      AppImages.bookmarkOutline,
                      height: 22,
                    ),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 2
                  ? const ImageView.svg(
                      AppImages.notifications,
                      height: 25,
                    )
                  : const ImageView.svg(
                      AppImages.notificationsOutline,
                      height: 25,
                    ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 3
                  ? const ImageView.svg(
                      AppImages.profile,
                      height: 26,
                    )
                  : const ImageView.svg(
                      AppImages.profileOutline,
                      height: 28,
                    ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.lightSecondary,
          onTap: _onItemTapped,
          unselectedItemColor: Colors.black38,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
