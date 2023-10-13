import 'package:fikkton/ui/landing_page_component/homepage/movie_details_page.dart';
import 'package:fikkton/ui/landing_page_component/homepage/search_page.dart';
import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/utils/navigator/page_navigator.dart';
import 'package:flutter/material.dart';

import '../../../res/app_images.dart';
import '../../widgets/modals.dart';
import '../movie.dart';
import 'widgets/filter_container.dart';
import '../../widgets/image_view.dart';
import 'widgets/filter_modal.dart';
import 'widgets/movies_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  String recent = 'Recent';
  String types = 'All Types';
  String genres = 'All Genres';

  final List<Widget> _pages = [
    _buildPage(),
    _buildPage(),
    _buildPage(),
    _buildPage(),
    _buildPage(),
  ];

  static Widget _buildPage() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          decoration: const BoxDecoration(),
          child: Stack(
            children: [
              const ImageView.asset(AppImages.house, fit: BoxFit.cover),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.black38,
                ),
              ),
              Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    'Tv Series'.toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  )),
              const Positioned(
                  top: 20,
                  right: 20,
                  child: Text(
                    '3 min ago',
                    style: TextStyle(color: Colors.white),
                  )),
              const Positioned(
                  bottom: 40,
                  right: 0,
                  left: 0,
                  child: Align(
                      child: Text(
                    'House Of The Dragon - Season 1',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ))),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Explore',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    AppNavigator.pushAndStackPage(context,
                        page: const SearchPage());
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
            height: 26,
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Trending',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      )),
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(
                  height: 190,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: _pages,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FilterContainer(
                        text: recent,
                        onPressed: () {
                          Modals.showBottomSheetModal(context,
                              isDissmissible: true,
                              heightFactor: 0.8,
                              page: filterModalContent(
                                  filterItems: [
                                    'Recent',
                                    'Popular',
                                    'Oldest',
                                    'A - Z',
                                    'Z - A'
                                  ],
                                  title: 'Filter by',
                                  context: context,
                                  onPressed: (item) {
                                    Navigator.pop(context);
                                    setState(() {
                                      recent = item;
                                    });
                                  }));
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        text: types,
                        onPressed: () {
                          Modals.showBottomSheetModal(context,
                              isDissmissible: true,
                              heightFactor: 0.6,
                              page: filterModalContent(
                                  filterItems: [
                                    'Movies',
                                    'TV Series',
                                    'Drama',
                                  ],
                                  title: 'Filter by Type',
                                  context: context,
                                  onPressed: (item) {
                                    Navigator.pop(context);

                                    setState(() {
                                      types = item;
                                    });
                                  }));
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FilterContainer(
                        text: genres,
                        onPressed: () {
                          Modals.showBottomSheetModal(context,
                              isDissmissible: true,
                              heightFactor: 1.2,
                              page: filterModalContent(
                                  filterItems: [
                                    'Action',
                                    'Adventure',
                                    'Animation',
                                    'Comedy',
                                    'Crime',
                                    'Documentary',
                                    'Family',
                                    'Romance'
                                  ],
                                  title: 'Filter by Genres',
                                  context: context,
                                  onPressed: (item) {
                                    Navigator.pop(context);

                                    setState(() {
                                      genres = item;
                                    });
                                  }));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                    itemCount: 18,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                          onTap: () {
                            AppNavigator.pushAndStackPage(context,
                                page:   MovieDetailsScreen());
                          },
                          child: MoviesItems());
                    }),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? AppColors.lightSecondary : Colors.grey,
          ),
        ),
      );
    }
    return indicators;
  }
}
