import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../model/posts/get_posts.dart' as post;
import '../../model/view_models/user_view_model.dart';
import '../../res/app_colors.dart';



class CustomTab extends StatefulWidget {
 final List<post.Posts>  list1;
  final List<post.Pinned> list2;

  const CustomTab({super.key, required this.list1, required this.list2});
  @override
  _CustomTabState createState() => _CustomTabState(list1, list2);
}

class _CustomTabState extends State<CustomTab> {
  final List<post.Posts> list1;
  final List<post.Pinned> list2;
  int activeTabIndex = 0;

  _CustomTabState(this.list1, this.list2);

  void switchTab(int index) {
    setState(() {
      activeTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final account = Provider.of<UserViewModel>(context, listen: true);

    return Row(
          children: [
         if(list1.isNotEmpty)   GestureDetector(
              onTap: () {
                switchTab(0);

                account.setTabIndex(tabIndex: 0);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: activeTabIndex == 0 ? AppColors.lightSecondary : Colors.white,
                ),
                child: Text('Announcements', style: TextStyle(color: activeTabIndex == 0 ?  Colors.white  :AppColors.lightSecondary),),
              ),
            ),
          if(list1.isNotEmpty)  SizedBox(width: 12,),
           if(list2.isNotEmpty) GestureDetector(
              onTap: () {
                switchTab(1);
                account.setTabIndex(tabIndex: 1);

              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: activeTabIndex == 1 ? AppColors.lightSecondary : Colors.white,
                ),
                child: Text('Trends', style: TextStyle(color: activeTabIndex == 1 ?  Colors.white  :AppColors.lightSecondary),),
              ),
            ),
          ],
        );
  }
}
