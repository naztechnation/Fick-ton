import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  final String text;
  final Function onPressed;

  const FilterContainer(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightSecondary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.all(9.0),
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                          color: AppColors.lightSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  )),
              const Expanded(flex: 1, child: ImageView.svg(AppImages.dropDown)),
            ],
          ),
        ),
      ),
    );
  }
}
