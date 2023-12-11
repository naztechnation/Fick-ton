import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import 'button_view.dart';
import 'image_view.dart';

class EmptyWidget extends StatelessWidget {
  final void Function()? onRefresh;
  final String title;
  final String? description;
  const EmptyWidget({this.title='No data',
    this.description,
    this.onRefresh,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ImageView.asset(AppImages.failed),
              const SizedBox(height: 25),
              Text(title,
                  style: const TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w600)),
              if(description!=null)...[
                const SizedBox(height: 25),
                Text(
                    description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w400))
              ],
              if(onRefresh!=null)...[
                const SizedBox(height: 25),
                ButtonView(
                    onPressed: onRefresh ?? (){},
                    color: AppColors.lightSecondary,
                    child: const Text('Refresh',
                        style: TextStyle(fontWeight: FontWeight.w600,
                            fontSize: 18)))
              ]
            ],
          ),
        ),
      ),
    );
  }
}