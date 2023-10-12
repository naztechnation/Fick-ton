

import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../../ui/widgets/image_view.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        
        child: Column(children: [
          SafeArea(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.topLeft,
                child: ImageView.svg(
                  AppImages.arrowBack,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            )
        ],)),
    );
  }
}