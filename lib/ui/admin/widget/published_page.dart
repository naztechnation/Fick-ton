import 'package:fikkton/blocs/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../handlers/secure_handler.dart';
import '../../../model/posts/get_posts.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../../res/app_strings.dart';
import '../../../res/enum.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../landing_page_component/homepage/movie_details_page.dart';
import '../../landing_page_component/homepage/widgets/published_items.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';

class Published extends StatelessWidget {
  const Published({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const PublishedPage(),
    );
  }
}

class PublishedPage extends StatefulWidget {
  const PublishedPage({super.key});

  @override
  State<PublishedPage> createState() => _PublishedPageState();
}

class _PublishedPageState extends State<PublishedPage> {
  late UserCubit _userCubit;

  String token = '';

  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getPost(url: AppStrings.getPosts(token));
  }

  List<Posts> allPosts = [];

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is PostListsLoaded) {
              if (state.postLists.status == 1) {
                allPosts = _userCubit.viewModel.postsList.reversed.toList();

                user.setPublishedLength(
                    publishedLength: allPosts.length.toString());
              } else {
                Modals.showToast(state.postLists.message!,
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
            if (state is DeletePostLoaded) {
              if (state.deletePost.status == 1) {
                _userCubit.getPost(url: AppStrings.getPosts(token));
                Modals.showToast(
                  state.deletePost.message!,
                  messageType: MessageType.success,
                );
              } else {
                Modals.showToast(state.deletePost.message!,
                    messageType: MessageType.error);
              }
            }

            return (state is PostListsLoading || state is DeletePostLoading)
                ? const LoadingPage()
                : (allPosts.isEmpty)
                    ? const SizedBox(
                        height: 390,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('No Published Posts')),
                      )
                    : ListView.builder(
                        itemCount: allPosts.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return PublishedItems(
                            posts: allPosts[index],
                            onTap: () {
                              _deletePost(context, allPosts[index].id!);
                            },
                          );
                        });
          }),
    );
  }

  _deletePost(BuildContext ctx, String postId) {
    ctx.read<UserCubit>().deletePost(postId: postId, token: token, url: AppStrings.deletePost);
    FocusScope.of(ctx).unfocus();
  }
}
