import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';

import '../../ui/widgets/text_edit_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
bool showother =  false;
class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
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
            ),
            TextEditView(
              controller: TextEditingController(text: ''),
              borderWidth: 1,
              borderColor: AppColors.lightSecondary,
              filled: false,
              isDense: true,
              borderRadius: 12,
              suffixIcon: const Icon(Icons.close),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: ImageView.svg(
                  AppImages.search,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
              Visibility(
              visible: showother,
              child: GestureDetector(
                onTap: (){
                   setState(() {
                    showother = !showother;
                      
                    });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Previous Search",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8.0),
                    Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.close,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
              Visibility(
                visible: showother,
                child: const SizedBox(
                  height: 20,
                )),
            Visibility(
              visible: showother,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                          itemCount: 18,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 24),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Legender of the Seeker",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Padding(
                                    padding: EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      Icons.close,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: !showother,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                    showother = !showother;
                      
                    });
                    },
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.7,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: ImageView.asset(AppImages.empty)),
                        SizedBox(height: 40.0),
                        Text(
                          "Not Found",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          "We’re sorry, the keyword you  were looking for could not be found. Please search with another keywords.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
