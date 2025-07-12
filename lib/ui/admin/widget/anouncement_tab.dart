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
import '../../landing_page_component/homepage/announcement_item.dart';
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
      child: const AnnouncementsTab(),
    );
  }
}

class AnnouncementsTab extends StatefulWidget {
  const AnnouncementsTab({super.key});

  @override
  State<AnnouncementsTab> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<AnnouncementsTab> {
  late UserCubit _userCubit;

  String token = '';

  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getPost(url: AppStrings.getPosts(token));
  }

  List<Pinned> pinned = [];

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is PostListsLoaded) {
          if (state.postLists.status == 1) {
            // Modals.showToast(state.postLists.message ?? '',
            //     messageType: MessageType.success);
            pinned = state.postLists.data?.pinned ?? [];
          } else {
            // Modals.showToast(state.postLists.message ?? '',
            //     messageType: MessageType.success);
          }
        } else if (state is DeletePostLoaded) {
          if (state.deletePost.status == 1) {
            _userCubit.getPost(url: AppStrings.getPosts(token));
            Modals.showToast(
              state.deletePost.message ?? '',
              messageType: MessageType.success,
            );
          } else {
            Modals.showToast(state.deletePost.message ?? '',
                messageType: MessageType.error);
          }
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
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
                  _userCubit.getPost(url: AppStrings.getPosts(token)));
        }

        return (state is PostListsLoading ||
                state is DeletePostLoading ||
                state is CreatePostLoading)
            ? const LoadingPage()
            : (pinned.isEmpty)
                ? const SizedBox(
                    height: 390,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text('Announcements')),
                  )
                : ListView.builder(
                    itemCount: pinned.length,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return AnnounceItems(
                        pin: pinned[index],
                        onDeleteTapped: () {
                          _deletePost(context, pinned[index].id ?? '');
                        },
                      );
                    });
      }),
    );
  }

  _deletePost(BuildContext ctx, String postId) {
    ctx.read<UserCubit>().deletePinPost(
          postId: postId,
          token: token,
          url: AppStrings.deletePinned,
        );
    FocusScope.of(ctx).unfocus();
  }
}
