import 'package:fikkton/ui/widgets/button_view.dart';
import 'package:flutter/material.dart';

import '../../model/onboard_model/onboarding_contents.dart';
import '../../res/app_colors.dart';
import '../../res/app_images.dart';
import '../../res/app_routes.dart';
import '../../utils/navigator/page_navigator.dart';
import '../../utils/size_config.dart';
import '../auth/auth.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;
  List colors = [
    const Color(0xffDAD3C8).withOpacity(0.7),
    const Color(0xffFFE5DE).withOpacity(0.7),
    const Color(0xffDCF6E6).withOpacity(0.7),
  ];

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration:   BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        color: _currentPage != index ? Colors.white :AppColors.lightSecondary,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: _currentPage == index ? 7 : 8,
      curve: Curves.easeIn,
      width: _currentPage == index ? 30 : 8,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;

    return Scaffold(
      backgroundColor: colors[_currentPage],
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        AppImages.bg,
                      ),
                      fit: BoxFit.cover)),
            ),
             
            Positioned(
              bottom: 0,
              child: Container(
               
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration:  const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.rectangle, ), fit: BoxFit.cover)
                )
              ),
            ),
           
             
            Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) =>
                        setState(() => _currentPage = value),
                    itemCount: contents.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                           
                          const Spacer(),
                            Text(
                              contents[i].title,
                              textAlign: TextAlign.center,
                              
                              style: TextStyle(
                                
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: (width <= 550) ? 28 : 35,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              contents[i].desc,
                              textAlign: TextAlign.center,

                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white60,

                                fontSize: (width <= 550) ? 17 : 25,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      _currentPage + 1 == contents.length
                          ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ButtonView(
                                color: AppColors.lightSecondary,
                                borderColor: AppColors.lightSecondary,
                              borderRadius: 30,
                              onPressed: (){
                                 AppNavigator.pushAndReplacePage(context, page: const LoginScreen());
                                 
                               
                            }, child: const Text("Start"),),
                          )
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal:16, vertical: 10),
                              child: ButtonView(
                                  color: AppColors.lightSecondary,
                                  borderColor: AppColors.lightSecondary,
                                borderRadius: 30,
                                onPressed: (){
                                  _controller.nextPage(
                                  duration:
                                      const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              }, child: const Text("NEXT"),),
                            ),
                            if(_currentPage + 1 != contents.length)  TextButton(
                                    onPressed: () {
                                      _controller.jumpToPage(2);
                                    },
                                    style: TextButton.styleFrom(
                                      elevation: 0,
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: (width <= 550) ? 13 : 17,
                                      ),
                                    ),
                                    child: const Text(
                                      "SKIP",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(height: 20,)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
