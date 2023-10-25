import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/landing_page_component/homepage/widgets/user_geograph.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../landing_page_component/homepage/widgets/navigation_helper.dart';
import '../widgets/image_view.dart';
import 'new_post.dart';
import 'widget/dashboard_container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<double> resultSummary = [
    10.5,
    20.5,
    30.5,
    40.5,
    50.5,
    60.5,
    60.5,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ImageView.asset(
                      AppImages.logo,
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Fik-kton',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    const Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            NavigationHelper.navigateToPage(
                                context, const NewPost(isUpdate: false, postId: '',));
                          },
                          child: const dashBoardContainer(
                            color: AppColors.lightSecondary,
                            txtColor: Colors.white,
                            description: ImageView.svg(AppImages.edit,
                                color: Colors.white,height: 28,),
                            imageUrl: '',
                            title: 'Create New Post',
                          ),
                        )),
                        const Expanded(
                            child: dashBoardContainer(
                          description: Text(
                            '18',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          imageUrl: AppImages.news,
                          title: 'Total Posts',
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Expanded(
                            child: dashBoardContainer(
                          description: Text(
                            '3750',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          imageUrl: AppImages.group,
                          title: 'Total Users',
                        )),
                        Expanded(
                            child: dashBoardContainer(
                          description: Text(
                            '11210',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          imageUrl: AppImages.visibility,
                          title: 'Total Views',
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "User Demographic",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 9,
                          width: 9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.lightPrimary,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text("Views"),
                        const SizedBox(width: 50),
                        Container(
                          height: 9,
                          width: 9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.lightPrimaryAccent,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text("Active Users"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white.withOpacity(.1),
                      ),
                      height: 300,
                      child: Demograph(
                        demoSummary: resultSummary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
