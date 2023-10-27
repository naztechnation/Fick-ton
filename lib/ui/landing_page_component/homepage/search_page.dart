import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/res/app_images.dart';
import 'package:fikkton/ui/widgets/image_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/posts/get_posts.dart';
import '../../../model/view_models/user_view_model.dart';
import '../../widgets/text_edit_view.dart';

class SearchPage extends StatefulWidget {

  final List<Posts> postsLists;
  const SearchPage({super.key, required this.postsLists});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
bool showother =  false;
class _SearchPageState extends State<SearchPage> {

  final searchController = TextEditingController();

  List<Posts> postsList = [];

  @override
  void initState() {
    postsList = widget.postsLists;
    super.initState();
  }


 void searchPostList(String query) {
    setState(() {
      postsList = widget.postsLists
          .where((posts) =>
              posts.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
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
            Row(
                children: [
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
                  const SizedBox(width: 30,),
                   const Text(
                          "Fik-kton",
                          style: TextStyle(fontSize: 18),
                        ),
                ],
              ),
            const SizedBox(
              height: 30,
            ),
            TextEditView(
              controller: searchController,
              borderWidth: 1,
              borderColor: AppColors.lightSecondary,
              filled: false,
              isDense: true,
              borderRadius: 12,
               onChanged: (query) {
                searchPostList(query);
              },
              suffixIcon: GestureDetector(
                onTap: (){
                  searchController.clear();
                },
                child: const Icon(Icons.close, size: 25, color: AppColors.lightPrimary,)),
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
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Search Results",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "(${postsList.length})",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            Expanded(
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
                if(postsList.isNotEmpty)...[
                  ListView.builder(
                        itemCount: postsList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            child:   Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    postsList[index].title!,
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
                                    Icons.arrow_forward_ios,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                ]else...[
                   SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: ImageView.asset(AppImages.empty, height: 160,)),
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
            )
                ]    
                  ],
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
