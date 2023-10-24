
 import 'dart:io';

import 'package:fikkton/model/auth_model/login.dart';

abstract class UserRepository {
  Future<AuthData> createPost({
    required String title,
    required String token,
    required String content,
    required File thumbnail,
    required String videoLink,
    required String genre,
    required String status,
    required String author,
    required String trending,
    
    });   

//     Future<GetServiceTypes> getServiceTypes(); 
//     Future<GetReviews> getReviews({required String userId}); 
//     Future<GalleryAgents> getGallery({required String userId}); 
//     Future<GetAgentsPackages> getAgentPackages({required String agentId, required String serviceId,}); 
//     Future<PaymentResponse> confirmPayment({required String username, required String agentId, required String purchaseId}); 
//  Future<ServiceProvidersList> serviceProvided({required List<String> services,required String username,required String agentId});   

 }