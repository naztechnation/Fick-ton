import 'package:fikkton/ui/landing_page_component/homepage/movie_details_page.dart';
import 'package:fikkton/ui/landing_page_component/homepage/search_page.dart';
import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/widgets/loading_page.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../blocs/user/user.dart';
import '../../../handlers/secure_handler.dart';
import '../../../model/posts/get_posts.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_images.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/home_tab.dart';
import '../../widgets/modals.dart';

import 'anouncement_details.dart';
import 'widgets/filter_container.dart';
import '../../widgets/image_view.dart';
import 'widgets/filter_modal.dart';
import 'widgets/movies_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  late UserCubit _userCubit;

  String token = '';

  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getPost(url: AppStrings.getPosts(token));
  }

  List<Posts> allPosts = [];
  List<Posts> trendingPosts = [];
  List<String> filterByList = [];
  List<String> genresList = [];
  List<String> typeList = [];
  List<Pinned> pinned = [];

  String recent = 'Recent';
  String types = 'All Types';
  String genres = 'All Genres';

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  static Widget _buildPage(
      {required String image,
      required String title,
      required String genre,
      required BuildContext context,
      required Function onTap,
      required String time}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                ImageView.network(
                  image,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                  placeholder: AppImages.logo1,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.black38,
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 20,
                    child: Text(
                      genre.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    )),
                Positioned(
                    top: 20,
                    right: 20,
                    child: Text(
                      time,
                      style: const TextStyle(color: Colors.white),
                    )),
                Positioned(
                    bottom: 20,
                    right: 0,
                    left: 0,
                    child: Align(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ))),
                // const Positioned(
                //   top: 80,
                //   left: 0,
                //   right: 0,
                //   child: Align(
                //       alignment: Alignment.center,
                //       child: ImageView.svg(
                //         AppImages.play,
                //         height: 35,
                //       )),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildPage2({
    required String image,
    required BuildContext context,
    required Function onTap,
    required String content,
    required String time,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            decoration: const BoxDecoration(color: AppColors.lightSecondary),
            child: Stack(
              children: [
                if (image != '')
                  Hero(
                    tag: image,
                    child: ImageView.network(
                      image,
                      fit: BoxFit.cover,
                      width: MediaQuery.sizeOf(context).width,
                      placeholder: AppImages.logo1,
                    ),
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.black38,
                  ),
                ),
                Positioned(
                    top: 30,
                    right: 0,
                    left: 0,
                    child: Align(
                        child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            color: Colors.white,
                            wordSpacing: 4,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ))),
                Positioned(
                    bottom: 20,
                    right: 20,
                    child: Align(
                        child: Text(
                      time,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
        body: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PostListsLoaded) {
                if (state.postLists.status == 1) {
                  trendingPosts = _userCubit.viewModel.posts;
                  allPosts = _userCubit.viewModel.postsList;
                  filterByList = state.postLists.data?.filterBy ?? [];
                  genresList = state.postLists.data?.genres ?? [];
                  typeList = state.postLists.data?.type ?? [];
                  pinned = state.postLists.data?.pinned ?? [];
                } else {
                  Modals.showToast(state.postLists.message ?? '',
                      messageType: MessageType.error);
                }
              } else if (state is UserNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () =>
                      _userCubit.getPost(url: AppStrings.getPosts(token)),
                );
              } else if (state is UserNetworkErrApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () =>
                      _userCubit.getPost(url: AppStrings.getPosts(token)),
                );
              }

              return (state is PostListsLoading)
                  ? const LoadingPage()
                  : RefreshIndicator.adaptive(
                      color: AppColors.lightPrimary,
                      onRefresh: () async {
                        _userCubit.getPost(url: AppStrings.getPosts(token));
                      },
                      child: Column(
                        children: [
                          SafeArea(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.03,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
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
                                      'Explore',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                if (allPosts.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      AppNavigator.pushAndStackPage(context,
                                          page: SearchPage(
                                            postsLists: allPosts,
                                          ));
                                    },
                                    child: const ImageView.svg(
                                      AppImages.search,
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: CustomTab(
                                      list1: trendingPosts,
                                      list2: pinned,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 26,
                                  ),
                                  if (timeFormat.activeTab == 0) ...[
                                    if (pinned.isEmpty)
                                      ...[]
                                    else ...[
                                      SizedBox(
                                        height: 190,
                                        child: PageView(
                                          controller: _pageController,
                                          onPageChanged: (int page) {
                                            setState(() {
                                              _currentPage = page;
                                            });
                                          },
                                          children: <Widget>[
                                            for (var pin in pinned)
                                              _buildPage2(
                                                  context: context,
                                                  onTap: () {
                                                    AppNavigator
                                                        .pushAndStackPage(
                                                            context,
                                                            page: DetailsPage(
                                                              pinned: pin,
                                                            ));
                                                  },
                                                  image: pin.thumbnail ?? '',
                                                  content: pin.content
                                                          .toString()
                                                          .replaceAll(
                                                              '&amp;amp;', '')
                                                          .replaceAll(
                                                              '&amp;quot;', '"')
                                                          .replaceAll(
                                                              '\n', '') ??
                                                      '',
                                                  time: timeFormat
                                                      .getCurrentTime(int.parse(
                                                          pin.updatedAt ??
                                                              '0'))),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      if (pinned.length < 15)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _buildPageIndicator(
                                              pinned.length),
                                        ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ],
                                  if (timeFormat.activeTab == 1) ...[
                                    if (trendingPosts.isEmpty) ...[
                                      const SizedBox(
                                        height: 190,
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Text('No trending posts')),
                                      )
                                    ] else ...[
                                      SizedBox(
                                        height: 190,
                                        child: PageView(
                                          controller: _pageController,
                                          onPageChanged: (int page) {
                                            setState(() {
                                              _currentPage = page;
                                            });
                                          },
                                          children: <Widget>[
                                            for (var trendingPosts
                                                in trendingPosts)
                                              _buildPage(
                                                  context: context,
                                                  onTap: () {
                                                    AppNavigator.pushAndStackPage(
                                                        context,
                                                        page:
                                                            MovieDetailsScreen(
                                                          videoLinks: trendingPosts
                                                                  .videoLink ??
                                                              '',
                                                          postId: trendingPosts
                                                                  .id ??
                                                              '',
                                                        ));
                                                  },
                                                  image:
                                                      trendingPosts.thumbnail ??
                                                          '',
                                                  title: trendingPosts.title
                                                          .toString()
                                                          .replaceAll(
                                                              '&amp;amp;', '')
                                                          .replaceAll(
                                                              '&amp;quot;', '"')
                                                          .replaceAll(
                                                              '\n', '') ??
                                                      '',
                                                  genre:
                                                      trendingPosts.genre ?? '',
                                                  time: timeFormat
                                                      .getCurrentTime(int.parse(
                                                          trendingPosts
                                                                  .updatedAt ??
                                                              '0'))),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      if (trendingPosts.length < 15)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _buildPageIndicator(
                                              trendingPosts.length),
                                        ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ],
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FilterContainer(
                                          text: recent,
                                          onPressed: () {
                                            Modals.showBottomSheetModal(context,
                                                isDissmissible: true,
                                                heightFactor: 0.8,
                                                page: filterModalContent(
                                                    filterItems: filterByList,
                                                    title: 'Filter by',
                                                    context: context,
                                                    onPressed: (item) {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        recent = item;
                                                      });

                                                      _userCubit
                                                          .getFilteredPost(
                                                              token: token,
                                                              genre: genres,
                                                              type: types,
                                                              filterParams:
                                                                  recent);
                                                    }));
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // FilterContainer(
                                        //   text: types,
                                        //   onPressed: () {
                                        //     Modals.showBottomSheetModal(context,
                                        //         isDissmissible: true,
                                        //         heightFactor: 0.6,
                                        //         page: filterModalContent(
                                        //             filterItems: typeList,
                                        //             title: 'Filter by Type',
                                        //             context: context,
                                        //             onPressed: (item) {
                                        //               Navigator.pop(context);

                                        //               setState(() {
                                        //                 types = item;
                                        //               });

                                        //               _userCubit.getFilteredPost(
                                        //                   token: token,
                                        //                   genre: genres,
                                        //                   type: types,
                                        //                   filterParams: recent);
                                        //             }));
                                        //   },
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        FilterContainer(
                                          text: genres,
                                          onPressed: () {
                                            Modals.showBottomSheetModal(context,
                                                isDissmissible: true,
                                                heightFactor: 1,
                                                page: filterModalContent(
                                                    filterItems: genresList,
                                                    title: 'Filter by Genres',
                                                    context: context,
                                                    onPressed: (item) {
                                                      Navigator.pop(context);

                                                      setState(() {
                                                        genres = item;
                                                      });

                                                      _userCubit
                                                          .getFilteredPost(
                                                              token: token,
                                                              genre: genres,
                                                              type: types,
                                                              filterParams:
                                                                  recent);
                                                    }));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (allPosts.isEmpty) ...[
                                    Container(
                                      height: 390,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: ImageView.asset(
                                                AppImages.empty,
                                                height: 120,
                                              )),
                                          SizedBox(height: 40.0),
                                          Align(
                                              alignment: Alignment.center,
                                              child:
                                                  Text('No posts available')),
                                        ],
                                      ),
                                    )
                                  ] else ...[
                                    ListView.builder(
                                      padding: EdgeInsets.all(0),
                                        itemCount: allPosts.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                AppNavigator.pushAndStackPage(
                                                    context,
                                                    page: MovieDetailsScreen(
                                                      videoLinks:
                                                          allPosts[index]
                                                                  .videoLink ??
                                                              '',
                                                      postId:
                                                          allPosts[index].id ??
                                                              '',
                                                    ));
                                              },
                                              child: MoviesItems(
                                                  posts: allPosts[index]));
                                        }),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ])),
                          ),
                        ],
                      ),
                    );
            }));
  }

  DateTime minAgo = DateTime.now().subtract(const Duration(milliseconds: 1));
  DateTime dayAgo = DateTime.now().subtract(const Duration(days: 1));
  DateTime monthAgo = DateTime.now().subtract(const Duration(days: 31));

  List<Widget> _buildPageIndicator(int length) {
    List<Widget> reverseIndicators = [];
    for (int i = length - 1; i >= 0; i--) {
      reverseIndicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == (length - 1 - i)
                ? AppColors.lightSecondary
                : Colors.grey,
          ),
        ),
      );
    }
    return reverseIndicators;
  }
}
