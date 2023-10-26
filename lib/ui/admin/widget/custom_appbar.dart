import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TabBar? tabBar;

  const CustomAppBar({Key? key, required this.title, this.tabBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      bottom: tabBar,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
