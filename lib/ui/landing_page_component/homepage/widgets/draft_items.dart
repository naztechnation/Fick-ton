import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class DraftItems extends StatelessWidget {
  DraftItems({super.key});

  @override
  Widget build(BuildContext context) {
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
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const Stack(
                children: [
                  ImageView.asset(
                    AppImages.avengers,
                    height: 120,
                  ),
                  //
                ],
              )),
          const SizedBox(width: 16.0),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TV SERIES",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 12.0),
                Text(
                  "House Of The Dragon - Season 1",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today",
                    ),
                    SizedBox(width: 8.0),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: ImageView.svg(
                            AppImages.edit,
                            height: 20,
                          ),
                        ),
                        ImageView.asset(
                          AppImages.delete,
                          width: 25,
                          height: 25,
                          color: Colors.grey,
                        ),
                        ImageView.asset(
                          AppImages.uploadd,
                          width: 25,
                          height: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
