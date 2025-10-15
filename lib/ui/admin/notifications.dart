import 'package:fikkton/ui/admin/widget/notifications_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../blocs/user/user.dart';
import '../../handlers/secure_handler.dart';
import '../../model/posts/notification_model.dart';
import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository_impl.dart';
import '../../res/app_images.dart';
import '../widgets/empty_widget.dart';
import '../widgets/image_view.dart';
import '../widgets/loading_page.dart';
import '../widgets/modals.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) => UserCubit(
          userRepository: UserRepositoryImpl(),
          viewModel: Provider.of<UserViewModel>(context, listen: false)),
      child: const NotificationsScreen(),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late UserCubit _userCubit;

  String token = '';

  List<NotificationsInfo> notifications = [];

  getNotifications() async {
    _userCubit = context.read<UserCubit>();

    token = await StorageHandler.getUserToken() ?? '';

    _userCubit.getNotifications(token: token);
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserStates>(listener: (context, state) {
        if (state is NotificationsLoaded) {
          if (state.notify.status == 1) {
            notifications = state.notify.data ?? [];
            setState(() {});
          } else {}
        }
        if (state is DelNotificationsLoaded) {
          if (state.notify.status == 1) {
            Modals.showToast(state.notify.message ?? '');
            _userCubit.getNotifications(token: token);
          } else {}
        }
      }, builder: (context, state) {
        if (state is UserNetworkErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.getNotifications(token: token),
          );
        } else if (state is UserNetworkErrApiErr) {
          return EmptyWidget(
            title: 'Network error',
            description: state.message,
            onRefresh: () => _userCubit.getNotifications(token: token),
          );
        } else if (state is AdminAnalysisLoading) {
          return const LoadingPage();
        }

        return (state is NotificationsLoading ||
                state is DelNotificationsLoading)
            ? const LoadingPage()
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
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
                            'Mulo',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          'Notifications',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: NotificationTile(
                          notifications: notifications,
                          onDeleteTapped: (notifyId) {
                            deleteNotification(context, notifyId);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  deleteNotification(
    BuildContext ctx,
    String notifyId,
  ) {
    ctx.read<UserCubit>().deleteNotifications(notifyId: notifyId, token: token);
    FocusScope.of(ctx).unfocus();
  }
}
