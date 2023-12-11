import 'package:fikkton/model/posts/bookmark_lists.dart';
import 'package:fikkton/model/posts/get_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../../utils/navigator/page_navigator.dart';
import '../widgets/loading_page.dart';
import 'homepage/movie_details_page.dart';
import 'homepage/search_page.dart';
import 'homepage/widgets/movies_item.dart';

class BookMarkPage extends StatelessWidget {

  const BookMarkPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const BookMark(),
    );
  }
}

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  late UserCubit _userCubit;

  List<Posts> bookmarkList = [];

  String token = '';

  getBookMarks() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.bookmarkList(token: token);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  void initState() {
    getBookMarks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is BookmarkListLoaded) {
          if (state.bookmarkList.status == 1) {
            bookmarkList = state.bookmarkList.data ?? [];
          } else {}
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.bookmarkList(token: token, ),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.bookmarkList(token: token),
          );
        } else if (state is BookmarkListLoading) {
          return const LoadingPage();
        }

        return Column(
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
                        'Fik-kton',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.pushAndStackPage(context,
                          page:   SearchPage(postsLists: bookmarkList,));
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
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'My Bookmarks (${bookmarkList.length})',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    if(bookmarkList.isEmpty)...[
                   SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: ImageView.asset(AppImages.empty, height: 160,)),
                        SizedBox(height: 40.0),
                        Text(
                          "Empty",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "You don’t have any bookmarks at this time",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                ]else...[
                    ListView.builder(
                        itemCount: bookmarkList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return GestureDetector(
                              onTap: () {
                                AppNavigator.pushAndStackPage(context,
                                    page: MovieDetailsScreen(
                                      videoLinks:
                                          bookmarkList[index].videoLink ?? '',
                                      postId: bookmarkList[index].id ?? '',
                                    ));
                              },
                              child: MoviesItems(
                                posts: bookmarkList[index],
                              ));
                        }),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
          ]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
