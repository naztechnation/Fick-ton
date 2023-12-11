import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:fikkton/ui/widgets/modals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/posts/get_posts.dart';
import '../../../../model/view_models/user_view_model.dart';
import '../../../../utils/navigator/page_navigator.dart';
import 'anouncement_details.dart';

class AnnounceItems extends StatelessWidget {
  final Function onDeleteTapped;
  final Pinned pin;
  const AnnounceItems(
      {super.key, required this.pin, required this.onDeleteTapped});

  @override
  Widget build(BuildContext context) {
    final timeFormat = Provider.of<UserViewModel>(context, listen: true);

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              AppNavigator.pushAndStackPage(context,
                  page: DetailsPage(
                    pinned: pin,
                  ));
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: SizedBox(
                          height: 120,
                          width: 130,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: ImageView.network(
                                pin.thumbnail,
                                height: 120,
                                placeholder: AppImages.logo1,
                                fit: BoxFit.cover,
                              ))),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
                        height: 120,
                        width: 130,
                        color: Colors.black26,
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(
                      pin.content?.replaceAll('&amp;amp;', '')
      .replaceAll('&amp;quot;', '"')
      .replaceAll('\n', '') ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timeFormat.getCurrentTime(int.parse(pin.updatedAt ?? '0')),
                    ),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        Modals.showAlertOptionDialog(context,
                            title: 'Delete Announcement',
                            message:
                                'Are you sure you want to delete this Announcement. This cannot be Undone.',
                            callback: () {
                          onDeleteTapped();
                        });
                      },
                      child: const ImageView.asset(
                        AppImages.delete,
                        width: 25,
                        height: 25,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
