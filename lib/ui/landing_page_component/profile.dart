import 'package:fikkton/res/app_colors.dart';
import 'package:fikkton/ui/widgets/button_view.dart';
import 'package:fikkton/ui/widgets/text_edit_view.dart';
import 'package:flutter/material.dart';

import '../../res/app_images.dart';
import '../widgets/image_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.03,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 26,
        ),
       const Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.0),
          child:   Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Profile",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(
          height: 26,
        ),
         Expanded(
          child: SingleChildScrollView(
            child: Padding(
                        padding:const  EdgeInsets.symmetric(horizontal:16.0),

              child: Column(
                children: [
                  const SizedBox(
          height: 20,
        ),
                  TextEditView(
                    borderRadius: 16,
                    hintText: 'Kennedybosky@gmail.com',
                    controller: TextEditingController(text: ''), 
                  isDense: true,fillColor: const Color(0xfffeee
                  ),),
                  const SizedBox(
          height: 23,
        ),
        TextEditView(
                    borderRadius: 16,
                    controller: TextEditingController(text: ''), 
                    hintText: '090847575785',

                  isDense: true,fillColor: const Color(0xfffeee
                  ),),
                  const SizedBox(
          height: 23,
        ),
        TextEditView(
                    borderRadius: 16,
                    hintText: 'Female',

                    controller: TextEditingController(text: ''), 
                  isDense: true,fillColor: const Color(0xfffeee
                  ),),
                  const SizedBox(height: 50,),
                  ButtonView(onPressed: (){}, 
                  borderRadius: 30,
                  color: Colors.white, borderColor: AppColors.lightSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 20), 
                  child: const Text('Change Password', style: TextStyle(color: AppColors.lightPrimary, fontSize: 14),),),

                  const SizedBox(height:30,),
                  ButtonView(onPressed: (){}, 
                  borderRadius: 30,
                  color: Colors.white, borderColor: AppColors.lightSecondary,
                  padding: const EdgeInsets.symmetric(vertical: 20), 
                  child: const Text('View Admin', style: TextStyle(color: AppColors.lightPrimary, fontSize: 14),),)
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }
}
