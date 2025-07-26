import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/posts/admin_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../landing_page_component/homepage/widgets/navigation_helper.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import 'new_post.dart';
import 'widget/bar_chart.dart';
import 'widget/dashboard_container.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late UserCubit _userCubit;

  DashBoardAnalysis? analysis;

  String token = '';

  getDashboardAnalysis() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.dashboardAnalysis(token: token);
  }

  @override
  void initState() {
    getDashboardAnalysis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is AdminAnalysisLoaded) {
          if (state.analysis.status == 1) {
            analysis = state.analysis;
            setState(() {});
          } else {}
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.dashboardAnalysis(token: token),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.dashboardAnalysis(token: token),
          );
        } else if (state is AdminAnalysisLoading) {
          return const LoadingPage();
        }

        return (state is AdminAnalysisLoading)
            ? const LoadingPage()
            : SafeArea(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
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
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20),
                          child: Column(
                            children: [
                             
                              const Text(
                                'Dashboard',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
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
                                          context,
                                          const NewPost(
                                            isUpdate: false,
                                            postId: '',
                                          ));
                                    },
                                    child: const dashBoardContainer(
                                      color: AppColors.lightSecondary,
                                      txtColor: Colors.white,
                                      description: ImageView.svg(
                                        AppImages.edit,
                                        color: Colors.white,
                                        height: 28,
                                      ),
                                      imageUrl: '',
                                      title: 'Create New Post',
                                    ),
                                  )),
                                  Expanded(
                                      child: dashBoardContainer(
                                    description: Text(
                                      analysis?.data?.posts ?? '',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    imageUrl: AppImages.news,
                                    title: 'Total Posts',
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: dashBoardContainer(
                                    description: Text(
                                      analysis?.data?.users ?? '',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    imageUrl: AppImages.group,
                                    title: 'Total Users',
                                  )),
                                  Expanded(
                                      child: dashBoardContainer(
                                    description: Text(
                                      analysis?.data?.views ?? '',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    imageUrl: AppImages.visibility,
                                    title: 'Total Views',
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Material(
                                type: MaterialType.card,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "User Demographic",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
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
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: Color(0xffFF8150),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text("Views"),
                                          const SizedBox(width: 50),
                                          Container(
                                            height: 9,
                                            width: 9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              color: AppColors.lightSecondary,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          const Text("Active Users"),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      if (analysis != null) ...[
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 320,
                                          child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: AdminDashboardGraph(
                                                  analysis: analysis)),
                                        ),
                                      ] else ...[
                                        const Text("No values available"),
                                      ]
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }
}
