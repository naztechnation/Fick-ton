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
import '../../../res/enum.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/modals.dart';

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

    _userCubit.getPost(token: token);
  }

  List<Posts> allPosts = [];
  List<Posts> trendingPosts = [];

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
      required String time}) {
    return Padding(
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
                placeholder: AppImages.logo,
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
                  bottom: 40,
                  right: 0,
                  left: 0,
                  child: Align(
                      child: Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PostListsLoaded) {
                if (state.postLists.status == 1) {
                  trendingPosts = _userCubit.viewModel.posts.reversed.toList();
                  allPosts = _userCubit.viewModel.postsList.reversed.toList();
                } else {
                  Modals.showToast(state.postLists.message!,
                      messageType: MessageType.error);
                }
              } else if (state is UserNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getPost(token: token),
                );
              } else if (state is UserNetworkErrApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getPost(token: token),
                );
              }

              return (state is PostListsLoading)
                  ? const LoadingPage()
                  : Column(
                      children: [
                        SafeArea(
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                              GestureDetector(
                                onTap: () {
                                  AppNavigator.pushAndStackPage(context,
                                      page: const SearchPage());
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
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Trending',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    )),
                              ),
                              const SizedBox(
                                height: 26,
                              ),
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
                                    for (var trendingPosts in trendingPosts)
                                      _buildPage(
                                        context: context,
                                          image: trendingPosts.thumbnail!,
                                          title: trendingPosts.title!,
                                          genre: trendingPosts.genre!,
                                          time: trendingPosts.createdAt!),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildPageIndicator(),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    FilterContainer(
                                      text: recent,
                                      onPressed: () {
                                        Modals.showBottomSheetModal(context,
                                            isDissmissible: true,
                                            heightFactor: 0.8,
                                            page: filterModalContent(
                                                filterItems: [
                                                  'Recent',
                                                  'Popular',
                                                  'Oldest',
                                                  'A - Z',
                                                  'Z - A'
                                                ],
                                                title: 'Filter by',
                                                context: context,
                                                onPressed: (item) {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    recent = item;
                                                  });
                                                }));
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    FilterContainer(
                                      text: types,
                                      onPressed: () {
                                        Modals.showBottomSheetModal(context,
                                            isDissmissible: true,
                                            heightFactor: 0.6,
                                            page: filterModalContent(
                                                filterItems: [
                                                  'Movies',
                                                  'TV Series',
                                                  'Drama',
                                                ],
                                                title: 'Filter by Type',
                                                context: context,
                                                onPressed: (item) {
                                                  Navigator.pop(context);

                                                  setState(() {
                                                    types = item;
                                                  });
                                                }));
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    FilterContainer(
                                      text: genres,
                                      onPressed: () {
                                        Modals.showBottomSheetModal(context,
                                            isDissmissible: true,
                                            heightFactor: 1.2,
                                            page: filterModalContent(
                                                filterItems: [
                                                  'Action',
                                                  'Adventure',
                                                  'Animation',
                                                  'Comedy',
                                                  'Crime',
                                                  'Documentary',
                                                  'Family',
                                                  'Romance'
                                                ],
                                                title: 'Filter by Genres',
                                                context: context,
                                                onPressed: (item) {
                                                  Navigator.pop(context);

                                                  setState(() {
                                                    genres = item;
                                                  });
                                                }));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                  itemCount: allPosts.length,
                                  
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          AppNavigator.pushAndStackPage(context,
                                              page: MovieDetailsScreen(videoLinks: allPosts[index].videoLink!,postId: allPosts[index].id!,));
                                        },
                                        child: MoviesItems(
                                            posts: allPosts[index]));
                                  }),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )),
                        ),
                      ],
                    );
            }));
  }

 String formatTime(timestamp){
    String formattedTime = timestampToHoursAgo(timestamp);

    return formattedTime;
  }

  String timestampToHoursAgo(int timestamp) {
  final now = DateTime.now();
  final time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000); 

  final difference = now.difference(time);
  final hours = difference.inHours;

  if (hours == 0) {
    final minutes = difference.inMinutes;
    return '$minutes minutes ago';
  } else if (hours == 1) {
    return '1 hour ago';
  } else {
    return '$hours hours ago';
  }
}

  List<Widget> _buildPageIndicator() {
    List<Widget> reverseIndicators = [];
for (int i = trendingPosts.length - 1; i >= 0; i--) {
  reverseIndicators.add(
    Container(
      width: 8.0,
      height: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == (trendingPosts.length - 1 - i) ? AppColors.lightSecondary : Colors.grey,
      ),
    ),
  );
}
return reverseIndicators;

  }
}
