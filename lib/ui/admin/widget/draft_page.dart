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


class Draft extends StatelessWidget {
  const Draft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const DraftPage(),
    );
  }
}
class DraftPage extends StatefulWidget {
  const DraftPage({super.key});

  @override
  State<DraftPage> createState() => _DraftPageState();
}

class _DraftPageState extends State<DraftPage> {

  late UserCubit _userCubit;

  String token = '';

  getPosts() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getPost(url: AppStrings.getPosts(token));
  }

  List<Posts> draftedPosts = [];

  @override
  void initState() {
    getPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserViewModel>(context, listen: false);

    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is PostListsLoaded) {
                if (state.postLists.status == 1) {
                  
                  draftedPosts = _userCubit.viewModel.postsList.reversed.toList();

                  user.setDraftLength(draftedLength: draftedPosts.length.toString());
                } else {
                  Modals.showToast(state.postLists.message!,
                      messageType: MessageType.error);
                }
              } else if (state is UserNetworkErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getPost(url: AppStrings.getDraftedPosts(token)),
                );
              } else if (state is UserNetworkErrApiErr) {
                return EmptyWidget(
                  title: 'Network error',
                  description: state.message,
                  onRefresh: () => _userCubit.getPost(url: AppStrings.getDraftedPosts(token)),
                );
              }

              return (state is PostListsLoading)
                  ? const LoadingPage()
                  : ListView.builder(
            itemCount: 9,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                  onTap: () {
                    // AppNavigator.pushAndStackPage(context,
                    //     page: MovieDetailsScreen());
                  },
                  child: DraftItems(posts: draftedPosts[index],));
            });
  }),
    );
  }
}
