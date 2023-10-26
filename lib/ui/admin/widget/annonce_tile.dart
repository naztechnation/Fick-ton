import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../widgets/image_view.dart';

class AllUsersTile extends StatelessWidget {
  final List<String> items = [
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
      shrinkWrap:   true,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            horizontalTitleGap: 0,
            leading: Text('${index + 1}.'),
            title: Text(
              items[index].split(' ')[0],
              style: const TextStyle(
                fontSize: 18,
                color: AppColors.lightPrimary,
              ),
            ),
            subtitle: Text(items[index].split(' ')[1]),
            trailing: const ImageView.asset(
                            AppImages.delete,
                            width: 25,
                            height: 25,
                            color: Colors.red,
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
            title: Text(items[index].split(' ')[0], style: const TextStyle(color: AppColors.lightPrimary),),
            subtitle: Text(items[index].split(' ')[1]),
            trailing: const Icon(Icons.more_vert_rounded),
          ),
        );
      },
    );
  }
}
