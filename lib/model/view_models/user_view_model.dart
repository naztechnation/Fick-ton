 

// import 'package:petnity/model/user_models/gallery_data.dart';

// import '../../res/enum.dart';
// import '../account_models/agents_packages.dart';
// import '../user_models/reviews_data.dart';
// import '../user_models/service_provider_lists.dart';
// import '../user_models/service_type.dart';
// import 'base_viewmodel.dart';

// class UserViewModel extends BaseViewModel {
   
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



// }
