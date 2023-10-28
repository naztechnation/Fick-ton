

import 'dart:io';

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
import '../../landing_page_component/homepage/widgets/draft_items.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/loading_page.dart';
import '../../widgets/modals.dart';

class Announcements extends StatelessWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const AnnouncementsPage(),
    );
  }
}

class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<AnnouncementsPage> {
  late UserCubit _userCubit;

  String token = '';

  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getPost(url: AppStrings.getDraftedPosts(token));
  }

  List<Posts> draftedPosts = [];

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context, listen: true);

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is CreatePostLoaded) {
          if (state.createPost.status == 1) {
            Modals.showToast(state.createPost.message ?? '',
                messageType: MessageType.success);
            _userCubit.getPost(url: AppStrings.getDraftedPosts(token));
          } else {
            draftedPosts = [];
          }
        }
      }, builder: (context, state) {
        if (state is PostListsLoaded) {
          if (state.postLists.status == 1) {
            draftedPosts = _userCubit.viewModel.postsList.reversed.toList();

            user.setDraftLength(draftedLength: draftedPosts.length.toString());
          } else {
            Modals.showToast(state.postLists.message!,
                messageType: MessageType.error);
          }
        }
        if (state is CreatePostLoaded) {
          if (state.createPost.status == 1) {
            Modals.showToast(state.createPost.message!,
                messageType: MessageType.success);
            _userCubit.getPost(url: AppStrings.getDraftedPosts(token));
          } else {}
        } else if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () =>
                _userCubit.getPost(url: AppStrings.getDraftedPosts(token)),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () =>
                _userCubit.getPost(url: AppStrings.getDraftedPosts(token)),
          );
        }
        if (state is DeletePostLoaded) {
          if (state.deletePost.status == 1) {
            _userCubit.getPost(url: AppStrings.getDraftedPosts(token));
            Modals.showToast(
              state.deletePost.message ?? '',
              messageType: MessageType.success,
            );
          } else {
            Modals.showToast(state.deletePost.message!,
                messageType: MessageType.error);
          }
        }

        return (state is PostListsLoading ||
                state is DeletePostLoading ||
                state is CreatePostLoading)
            ? const LoadingPage()
            : (draftedPosts.isEmpty)
                ? const SizedBox(
                    height: 390,
                    child: Align(
                        alignment: Alignment.center, child: Text('No Drafts')),
                  )
                : ListView.builder(
                    itemCount: draftedPosts.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return DraftItems(
                        posts: draftedPosts[index],
                        onPublishedTapped: () async {
                          await user.fileFromImageUrl(
                              draftedPosts[index].thumbnail ?? '');

                          _publishDraft(
                              context,
                              token,
                              user.imageURl!,
                              '1',
                              AppStrings.updatePost,
                              draftedPosts[index].id ?? '',
                              draftedPosts[index].title ?? '',
                              draftedPosts[index].content ?? '',
                              draftedPosts[index].videoLink ?? '',
                              draftedPosts[index].genre ?? '',
                              draftedPosts[index].author ?? '',
                              draftedPosts[index].isTrending.toString());
                        },
                        onDeleteTapped: () {
                          _deletePost(context, draftedPosts[index].id!);
                        },
                      );
                    });
      }),
    );
  }

  _deletePost(BuildContext ctx, String postId) {
    ctx.read<UserCubit>().deletePost(postId: postId, token: token);
    FocusScope.of(ctx).unfocus();
  }

  _publishDraft(
      BuildContext ctx,
      String token,
      File thumbnail,
      String status,
      String url,
      String postId,
      String title,
      String content,
      String videoLink,
      String genre,
      String author,
      String trending) {
    ctx.read<UserCubit>().createPost(
          url: url,
          title: title,
          token: token,
          postId: postId,
          content: content,
          videoLink: videoLink,
          thumbnail: thumbnail,
          genre: genre,
          status: status,
          author: author,
          trending: trending,
        );
  }
}
