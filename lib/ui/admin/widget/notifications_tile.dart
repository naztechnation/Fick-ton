import 'package:fikkton/extentions/custom_string_extension.dart';
import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/posts/notification_model.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../../res/app_images.dart';
import '../../../utils/navigator/page_navigator.dart';
import '../../landing_page_component/notification/notifications_details.dart';
import '../../widgets/image_view.dart';
import '../../widgets/modals.dart';

class NotificationTile extends StatelessWidget {
  final List<NotificationsInfo> notifications;
  final Function(String notifyId) onDeleteTapped;

  const NotificationTile(
      {super.key, required this.notifications, required this.onDeleteTapped});

  @override
  Widget build(BuildContext context) {
    final timeFormat = Provider.of<UserViewModel>(context, listen: false);

    return ListView.builder(
      itemCount: notifications.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              horizontalTitleGap: 0,
              leading: Text('${index + 1}.'),
              title: GestureDetector(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: NotificationsDetails(
                        title: notifications[0].title ?? '',
                        description: notifications[0].content ?? '',
                        date: notifications[0].createdAt ?? '',
                      ));
                },
                child: Text(
                  notifications[index].title.toString().capitalizeFirstOfEach ??
                      '',
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lightPrimary,
                  ),
                ),
              ),
              subtitle: GestureDetector(
                onTap: () {
                  AppNavigator.pushAndStackPage(context,
                      page: NotificationsDetails(
                        title: notifications[0].title ?? '',
                        description: notifications[0].content ?? '',
                        date: notifications[0].createdAt ?? '',
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifications[index].content ?? '',
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            wordSpacing: 0, fontSize: 15, color: Colors.black),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                       timeFormat.getCurrentTime(int.parse(notifications[index].createdAt ?? '')),  
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            wordSpacing: 0, fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Modals.showAlertOptionDialog(context,
                      title: 'Delete Notification',
                      message:
                          'Are you sure you want to delete this notification. This cannot be Undone.',
                      callback: () {
                    onDeleteTapped(notifications[index].id ?? '');
                  });
                },
                child: const ImageView.asset(
                  AppImages.delete,
                  width: 25,
                  height: 25,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class OtherUsersTile extends StatelessWidget {
  final List<String> items = [
    'john.doe@example.com 0812734667',
    'jane.smith@example.com 0812734667',
    'alice.johnson@example.com 0812734667',
    'bob.wilson@example.com 0812734667',
    'eve.parker@example.com 0812734667',
    'john.doe@example.com 0812734667',
    'jane.smith@example.com 0812734667',
    'alice.johnson@example.com 0812734667',
    'bob.wilson@example.com 0812734667',
    'eve.parker@example.com 0812734667',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Text('${index + 1}.'),
            title: Text(
              items[index].split(' ')[0],
              style: const TextStyle(color: AppColors.lightPrimary),
            ),
            subtitle: Text(items[index].split(' ')[1]),
            trailing: const Icon(Icons.more_vert_rounded),
          ),
        );
      },
    );
  }
}
