

import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/image_view.dart';
import '../../utils/navigator/page_navigator.dart';
import 'homepage/movie_details_page.dart';
import 'homepage/search_page.dart';
import 'homepage/widgets/movies_item.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Column(
        children: [
           SafeArea(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
          ),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  const Row(
                  children: [
                    ImageView.svg(
                      AppImages.logo,
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Fik-kton',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context, page: const SearchPage());
                  },
                  child: const ImageView.svg(
                    AppImages.search,
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
            
          ),
           const Align(
            alignment: Alignment.topLeft,
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 16.0),
               child: Text(
                          'My Bookmarks (33)',
                          style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
             ),
           ),
                     const SizedBox(
                  height: 20,
                ),
            Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
               
         
                ListView.builder(
                    itemCount: 18,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: (){
                          AppNavigator.pushAndStackPage(context, page:   MovieDetailsScreen());
                        },
                        child: MoviesItems());
                    }),
                const SizedBox(
                  height: 30,
                ),
              ],),
            ),
          ),
        ],
      ),
    );
  }
}