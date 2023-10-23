 
// import 'package:petnity/model/account_models/agents_packages.dart';
// import 'package:petnity/model/account_models/confirm_payment.dart';

// import '../../../model/user_models/gallery_data.dart';
// import '../../../model/user_models/reviews_data.dart';
// import '../../../model/user_models/service_provider_lists.dart';
// import '../../../model/user_models/service_type.dart';
// import '../../../res/app_strings.dart';
// import '../../setup/requests.dart';
// import 'user_repository.dart';

// class UserRepositoryImpl implements UserRepository {
 
  
//   @override
//   Future<ServiceProvidersList> getServiceProviderList({required String serviceId}) async {
//     final map = await Requests().get(AppStrings.getServiceProvidersList(serviceId), headers: {
//       'Authorization': AppStrings.token,
//      });
//     return ServiceProvidersList.fromJson(map);
//   }

// @override
//   Future<GetServiceTypes> getServiceTypes() async {
//     final map = await Requests().get(AppStrings.getServiceTypes, headers: {
//       'Authorization': AppStrings.token,
//      });
//     return GetServiceTypes.fromJson(map);
//   }

//   @override
//   Future<ServiceProvidersList> serviceProvided(
//       {required List<String> services,
//       required String username,
//       required String agentId}) async {
//     final map = await Requests().patch(AppStrings.selectServiceTypeUrl(agentId),
//         body: {
//           "service_types": services
//         },
//         headers: {
//           'Authorization': AppStrings.token,
//           "Content-type": "application/json"
//         });
//     return ServiceProvidersList.fromJson(map);
//   }
  
//   @override
//   Future<GetReviews> getReviews({required String userId}) async{
     
//     final map = await Requests().get(AppStrings.getReviewUrl(userId), headers: {
//       'Authorization': AppStrings.token,
//      });
//     return GetReviews.fromJson(map);
//   }
//    @override
//   Future<GalleryAgents> getGallery({required String userId}) async{
     
//     final map = await Requests().get(AppStrings.getGalleryUrl(userId), headers: {
//       'Authorization': AppStrings.token,
//      });
//     return GalleryAgents.fromJson(map);
//   }

//   @override
//   Future<GetAgentsPackages> getAgentPackages({required String agentId, required String serviceId}) async{
     
//     final map = await Requests().get(AppStrings.getAgentPackagesUrl(agentId,serviceId), headers: {
//       'Authorization': AppStrings.token,
//      });
//     return GetAgentsPackages.fromJson(map);
//   }

//   @override
//   Future<PaymentResponse> confirmPayment({required String username, required String agentId, required String purchaseId, }) async{
     
//     final map = await Requests().post(AppStrings.confirmPaymentUrl(username,agentId),
//     body: {
//           "purchase_id": purchaseId
//         },
//      headers: {
//       'Authorization': AppStrings.token,
      
//      });
//     return PaymentResponse.fromJson(map);
//   }

// }
