import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../handlers/secure_handler.dart';
import '../../res/enum.dart';
import 'base_viewmodel.dart';

class AccountViewModel extends BaseViewModel {
  AccountViewModel() {
    _getToken();
  }

  String _token = "";

//   File? _imageURl;

//   UserType _userType = UserType.none;

//   ImagePicker picker = ImagePicker();

//   bool _showPassword = false;

  setToken(String token) async {
    _token = token;

    StorageHandler.saveUserToken(_token);
    setViewState(ViewState.success);
  }

  _getToken() async {
    _token = await StorageHandler.getUserToken() ?? '';
    setViewState(ViewState.success);
  }

//   getUsername() async {
//     _username = await StorageHandler.getUserName();
//     setViewState(ViewState.success);
//   }

//   setPackageId(String id)async {
//     _packageId  = id;
//     setViewState(ViewState.success);
//   }

//   setAgentId(String agentId)async {
//     _agentId2  = agentId;
//     setViewState(ViewState.success);
//   }

//    setServiceId(String serviceId)async {
//     _serviceId  = serviceId;
//     setViewState(ViewState.success);
//   }

//   setServicePrice(String price)async {
//     _servicePrice  = price;
//     setViewState(ViewState.success);
//   }
//   setServicePackage(String package)async {
//     _servicePackage  = package;
//     setViewState(ViewState.success);
//   }

//   setServiceDuration(String duration)async {
//     _serviceDuration  = duration;
//     setViewState(ViewState.success);
//   }

//   getUserId() async {
//     _agentId = await StorageHandler.getAgentId();
//     setViewState(ViewState.success);
//   }

//   showPassword() {
//     _showPassword = !_showPassword;
//     setViewState(ViewState.success);
//   }

//   setPetId(String petId) {
//     _petId = petId;
//     setViewState(ViewState.success);
//   }
//   setUserLocation(String location) {
//     _userLocation = location;
//     setViewState(ViewState.success);
//   }

//   Future<void> _intData() async {
//     final position = await LocationHandler.determinePosition();
//     await setLongLat(
//         latitude: position.latitude, longitude: position.longitude);
//   }

//   setPetType(String petType) {
//     _petType = petType;
//     setViewState(ViewState.success);
//   }

//   setPetTypeIndex(String petTypeIndex) {
//     _petTypeIndex = petTypeIndex;
//     setViewState(ViewState.success);
//   }

//   setPetName(String petName) {
//     _petName = petName;
//     setViewState(ViewState.success);
//   }

//   setPetGender(String petGender) {
//     _petGender = petGender;
//     setViewState(ViewState.success);
//   }

//   setPetSize(String petSize) {
//     _petSize = petSize;
//     setViewState(ViewState.success);
//   }

//   setAboutPet(String aboutPet) {
//     _aboutPet = aboutPet;
//     setViewState(ViewState.success);
//   }

//   setPetBreed(String petBreed) {
//     _petBreed = petBreed;
//     setViewState(ViewState.success);
//   }

//   setUserType(UserType userType) {
//     _userType = userType;
//     setViewState(ViewState.success);
//   }

//   Future<void> setUserData({required String username}) async {
//     _username = username;
//     setViewState(ViewState.success);
//   }

//   loadImage(BuildContext context) async {
//     await showModalBottomSheet<dynamic>(
//         context: context,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
//         builder: (BuildContext bc) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               const SizedBox(height: 15),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     left: 30.0, right: 8.0, top: 8.0, bottom: 8.0),
//                 child: Text('Select the images source',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Theme.of(context).colorScheme.secondary,
//                         fontWeight: FontWeight.bold)),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.photo_camera,
//                   size: 35.0,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//                 title: const Text('Camera'),
//                 onTap: () async {
//                   Navigator.pop(context);

//                   final image = await ImagePicker().pickImage(
//                       source: ImageSource.camera,
//                       imageQuality: 80,
//                       maxHeight: 1000,
//                       maxWidth: 1000);
//                   _imageURl = File(image!.path);
//                   setViewState(ViewState.success);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.photo,
//                   size: 35.0,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//                 title: const Text('Gallery'),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   final image = await ImagePicker().pickImage(
//                       source: ImageSource.gallery,
//                       imageQuality: 80,
//                       maxHeight: 1000,
//                       maxWidth: 1000);
//                   _imageURl = File(image!.path);
//                   setViewState(ViewState.success);
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   Future<void> setAddress(String address) async {
//     _address = address;
//     setViewState(ViewState.success);
//   }

//   Future<void> setSelectedService(String selectedService) async {
//     _selectedService = selectedService;
//     setViewState(ViewState.success);
//   }

//   Future<String> uploadImage(String imageUrl, String uploadPreset) async{
//     final url = Uri.parse('https://api.cloudinary.com/v1_1/do2z93mmw/upload');

//     String image = '';

//     try {
//       final request = http.MultipartRequest('POST', url)
//         ..fields['upload_preset'] = uploadPreset
//         ..files.add(await http.MultipartFile.fromPath('file', imageUrl));

//         final response = await request.send();

//         if(response.statusCode == 200){
//           final responseData = await response.stream.toBytes();
//           final resPonseString = String.fromCharCodes(responseData);
//           final jsonMap = jsonDecode(resPonseString);

//             image = jsonMap['url'];

//            return image;
//         }
//     } catch (e) {

//     }

//      return image;
//   }

//   Future<void> deleteUser() async {

//     await StorageHandler.clearCache();
//     setViewState(ViewState.success);
//   }

//   String get selectedService => _selectedService;

//   Future<void> setLongLat(
//       {required double latitude, required double longitude}) async {
//     _longitude = longitude;
//     _latitude = latitude;
//       final addresses = await placemarkFromCoordinates(
//     _latitude,
//     _longitude,
//   );

//   if (addresses.isNotEmpty) {
//     final firstAddress = addresses.first;
//     final address = "${firstAddress.locality},  ${firstAddress.country}";

//    _address =  address;
//   } else {
//     _address = '';
//   }
//     setViewState(ViewState.success);
//   }

//   void changeSelectedIndex(int newIndex) {
//     _selectedIndex = newIndex;
//    setViewState(ViewState.success);
//   }

//   Future<void> signInAnonymously() async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
//     User? user = userCredential.user;
//     print("Signed in anonymously with UID: ${user?.uid}");
//   } catch (e) {
//     print("Error signing in anonymously: $e");
//   }
// }

//   double get longitude => _longitude;
   String get token => _token;
//   String get location => _userLocation;
//   String get agentName => _agentName;
//   String get serviceId => _serviceId;
//   String get servicePrice => _servicePrice;
//   String get servicePackage => _servicePackage;
//   String get serviceDuration => _serviceDuration;
//   String get agentId2 => _agentId2;
//   String get packageId => _packageId;

//   double get latitude => _latitude;
//   bool get showPasswordStatus => _showPassword;
//   String get username => _username;
//   String get petType => _petType;
//   String get serviceProviderId => _agentId;
//   String get petTypeIndex => _petTypeIndex;
//   String get petName => _petName;
//   String get petGender => _petGender;
//   String get petBreed => _petBreed;
//   String get petSize => _petSize;
//   String get aboutPet => _aboutPet;
//   String get petId => _petId;
//   File? get imageURl => _imageURl;
//   UserType get userType => _userType;
//   int get selectedIndex => _selectedIndex;
}
