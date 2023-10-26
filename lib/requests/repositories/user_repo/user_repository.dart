
 import 'dart:io';

import 'package:fikkton/model/auth_model/login.dart';
import 'package:fikkton/model/posts/bookmark_lists.dart';
import 'package:fikkton/model/posts/comment_lists.dart';
import 'package:fikkton/model/posts/post_details.dart';

import '../../../model/posts/get_posts.dart';

abstract class UserRepository {
  Future<AuthData> createPost({
    required String title,
    required String url,
    required String token,
    required String content,
    required File thumbnail,
    required String videoLink,
    required String genre,
    required String status,
    required String author,
    required String trending,
    
    });   

     Future<GetAllPosts> getAllPosts({ required String url});
     Future<PostDetails> getPostsDetails({required String token, required String postId});
     Future<AuthData> addComment({required String token, required String postId, required String comment});
     Future<CommentData> getComment({required String token, required String postId, });
     Future<AuthData> deletePost({required String token, required String postId, });
     Future<AuthData> likeBookmark({required String token, required String postId,  required String url});
     Future<BookmarkList> bookmarkList({required String token, });
     Future<AuthData> createNotification({required String token,required String title,required String content});


//     Future<GetReviews> getReviews({required String userId}); 
//     Future<GalleryAgents> getGallery({required String userId}); 
//     Future<GetAgentsPackages> getAgentPackages({required String agentId, required String serviceId,}); 
//     Future<PaymentResponse> confirmPayment({required String username, required String agentId, required String purchaseId}); 
//  Future<ServiceProvidersList> serviceProvided({required List<String> services,required String username,required String agentId});   

 }