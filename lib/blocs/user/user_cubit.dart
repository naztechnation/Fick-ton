
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/view_models/user_view_model.dart';
import '../../requests/repositories/user_repo/user_repository.dart';

 
 import '../../utils/exceptions.dart';
import 'user_states.dart';

 class UserCubit extends Cubit<UserStates> {


  UserCubit({required this.userRepository, required this.viewModel})
      : super(const InitialState());
  final UserRepository userRepository;
  final UserViewModel viewModel;

  Future<void> createPost({required String title,
    required String token,
    required String content,
    required File thumbnail,
    required String videoLink,
    required String genre,
    required String status,
    required String author,
    required String trending,}) async {
    try {
      emit(CreatePostLoading());

      final agents = await userRepository.createPost(
        title: title,
        token: token,
        content: content,
        videoLink: videoLink,
        thumbnail: thumbnail,
        genre: genre,
        status: status,
        author: author,
        trending: trending,
       
       );

      
      emit(CreatePostLoaded(agents));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }

  Future<void> getPost({
    required String token,
    }) async {
    try {
      emit(PostListsLoading());

      final posts = await userRepository.getAllPosts(
        
        token: token,
        
       
       );

       await viewModel.setPostLists(posts:posts);
      
      emit(PostListsLoaded(posts));
    } on ApiException catch (e) {
      emit(UserNetworkErrApiErr(e.message));
    } catch (e) {
      if (e is NetworkException ||
          e is BadRequestException ||
          e is UnauthorisedException ||
          e is FileNotFoundException ||
          e is AlreadyRegisteredException) {
        emit(UserNetworkErr(e.toString()));
      } else {
        rethrow;
      }
    }
  }
  
//   Future<void> getServiceTypes() async {
//     try {
//       emit(ServiceProviderListLoading());

//       final service = await userRepository.getServiceTypes(
//        );

//        await viewModel.setServicesList(services:service.serviceTypes ?? []);


//       emit(ServicesLoaded(service));
//     } on ApiException catch (e) {
//       emit(UserNetworkErrApiErr(e.message));
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         emit(UserNetworkErr(e.toString()));
//       } else {
//         rethrow;
//       }
//     }
//   }

//   Future<void> serviceProvided({required List<String> services,required String username, required String agentId}) async {
//     try {
//       emit(ServiceProviderListLoading());

//       final user = await userRepository.serviceProvided(services: services, username: username, agentId: agentId
//           );
 
//       emit(ServiceProviderListLoaded(user));
//     } on ApiException catch (e) {
//       emit(UserNetworkErrApiErr(e.message));
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         emit(UserNetworkErr(e.toString()));
//       } else {
//         rethrow;
//       }
//     }
//   }

//     Future<void> getReviews({ required String userId}) async {
//     try {
//       emit(ReviewLoading());

//       final reviews = await userRepository.getReviews(
//          userId: userId
//           );
//        await viewModel.setReviews(reviews:reviews);
 
//       emit(ReviewLoaded(reviews));
//     } on ApiException catch (e) {
//       emit(UserNetworkErrApiErr(e.message));
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         emit(UserNetworkErr(e.toString()));
//       } else {
//         rethrow;
//       }
//     }
//   }

//     Future<void> getGallery({ required String userId}) async {
//     try {
//       emit(GalleryLoading());

//       final gallery = await userRepository.getGallery(
//          userId: userId
//           );
//        await viewModel.setGallery(gallery:gallery);
 
//       emit(GalleryLoaded(gallery));
//     } on ApiException catch (e) {
//       emit(UserNetworkErrApiErr(e.message));
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         emit(UserNetworkErr(e.toString()));
//       } else {
//         rethrow;
//       }
//     }
//   }

//   Future<void> getAgentPackages({ required String agentId, required String serviceId}) async {
//     try {
//       emit(AgentPackagesLoading());

//       final packages = await userRepository.getAgentPackages(agentId: agentId, serviceId: serviceId
          
//           );
//        await viewModel.setAgentPackages(agentPackage:packages);
 
//       emit(AgentPackagesLoaded(packages));
//     } on ApiException catch (e) {
//       emit(UserNetworkErrApiErr(e.message));
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         emit(UserNetworkErr(e.toString()));
//       } else {
//         rethrow;
//       }
//     }
//   }

//   Future<void> confirmPayment({ required String agentId, required String username,  required String purchaseId}) async {
//     try {
//       emit(ConfirmPaymentLoading());

//       final payment = await userRepository.confirmPayment(agentId: agentId, username: username, purchaseId: purchaseId
          
//           );
      
//       emit(ConfirmPaymentLoaded(payment));
//     } on ApiException catch (e) {
//       emit(UserNetworkErrApiErr(e.message));
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         emit(UserNetworkErr(e.toString()));
//       } else {
//         rethrow;
//       }
//     }
//   }

 }