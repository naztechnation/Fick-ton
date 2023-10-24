// import 'package:petnity/model/user_models/gallery_data.dart';

// import '../../res/enum.dart';
// import '../account_models/agents_packages.dart';
// import '../user_models/reviews_data.dart';
// import '../user_models/service_provider_lists.dart';
// import '../user_models/service_type.dart';
import 'dart:io';

import 'package:fikkton/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../res/enum.dart';
import 'base_viewmodel.dart';

class UserViewModel extends BaseViewModel {
  ImagePicker picker = ImagePicker();

  File? _imageURl;

//    List<ServiceTypes> _services = [];
//    List<Packages> _packages = [];
//    List<Agents> _agents = [];
//    List<Reviews> _reviews = [];
//    List<GalleryElements> _gallery = [];
//    bool _reviewStatus = false;
//    bool _galleryStatus = false;

//    Future<void> setServicesList({required List<ServiceTypes> services}) async {
//     _services = services;
//     setViewState(ViewState.success);
//   }
//    Future<void> setAgentDetails({required List<Agents> agents}) async {
//     _agents = agents;
//     setViewState(ViewState.success);
//   }

//    Future<void> setAgentPackages({required GetAgentsPackages agentPackage}) async {
//     _packages = agentPackage.packages ?? [];
//     setViewState(ViewState.success);
//   }
//   Future<void> emptyReviews() async {
//     _galleryStatus =  false;
//     _gallery =  [];
//     setViewState(ViewState.success);
//   }

//    Future<void> emptyGallery() async {
//     _reviewStatus =  false;
//     _reviews =  [];
//     setViewState(ViewState.success);
//   }

//   Future<void> setReviews({required GetReviews reviews}) async {
//     _reviewStatus = reviews.status ?? false;
//     _reviews = reviews.reviews ?? [];
//     setViewState(ViewState.success);
//   }

//   Future<void> setGallery({required GalleryAgents gallery}) async {
//     _galleryStatus = gallery.status ?? false;
//     _gallery = gallery.galleryElements ?? [];
//     setViewState(ViewState.success);
//   }

//   List<ServiceTypes> get services => _services;
//   List<Agents> get agents => _agents;
//   List<Packages> get packages => _packages;
//   List<Reviews> get reviews => _reviews;
//   List<GalleryElements> get gallery => _gallery;
//   bool get reviewStatus => _reviewStatus;
//   bool get galleryStatus => _galleryStatus;
//    List<ServicesDetails> get servicesItems => servicesResults();
//    List<Pets> get servicesPetList => servicesPets();

//   List<ServicesDetails> servicesResults() {
//     List<ServicesDetails> list = [];

//     for (var service in _agents ?? []) {
//       list.addAll(service.services);
//     }

//     return list;
//   }

//    List<Pets> servicesPets() {
//     List<Pets> list = [];

//     for (var servicePets in _agents ?? []) {
//       list.addAll(servicePets.petTypes);
//     }

//     return list;
//   }

  loadImage(BuildContext context) async {
    await showModalBottomSheet<dynamic>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.only(
                    left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
                child: Text('Select the images source',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_camera,
                  size: 35.0,
                  color: AppColors.lightPrimary,
                ),
                title: const Text('Camera', style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(context);

                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  _imageURl = File(image!.path);
                  setViewState(ViewState.success);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo,
                  size: 35.0,
                  color: AppColors.lightPrimary,
                ),
                title: const Text('Gallery',style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightSecondary,
                        fontWeight: FontWeight.w600)),
                onTap: () async {
                  Navigator.pop(context);
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 80,
                      maxHeight: 1000,
                      maxWidth: 1000);
                  _imageURl = File(image!.path);
                  setViewState(ViewState.success);
                },
              ),
            ],
          );
        });
  }

  File? get imageURl => _imageURl;
}
