
 import 'dart:io';

import 'package:fikkton/model/auth_model/login.dart';
import 'package:fikkton/model/posts/bookmark_lists.dart';
import 'package:fikkton/model/posts/comment_lists.dart';
import 'package:fikkton/model/posts/post_details.dart';
import 'package:fikkton/ui/landing_page_component/notification/notifications_details.dart';

import '../../../model/posts/admin_model.dart';
import '../../../model/posts/get_posts.dart';
import '../../../model/posts/notification_model.dart';

abstract class UserRepository {
  Future<AuthData> createPost({
    required String title,
    required String url,
    required String token,
    required String postId,
    required String content,
    required File thumbnail,
    required String videoLink,
    required String genre,
    required String status,
    required String author,
    required String trending,
    
    });   

     Future<GetAllPosts> getAllPosts({ required String url});
     Future<GetAllPosts> filterPost({ required String token, required String genre, required String filterParams,required String type});
     Future<PostDetails> getPostsDetails({required String token, required String postId});
     Future<CommentData> createComment({required String token, required String postId, required String comment});
     Future<CommentData> getComment({required String token, required String postId, });
     Future<AuthData> deletePost({required String token, required String postId,required String url,});
     Future<AuthData> deletePinPost({required String token, required String postId,required String url,});
     Future<AuthData> deleteNotification({required String token, required String notifyId, });
     Future<AuthData> likeBookmark({required String token, required String postId,  required String url,   });
     Future<BookmarkList> bookmarkList({required String token, });
     Future<DashBoardAnalysis> dashboardAnalysis({required String token, });
     Future<NotificationData> getNotifications({required String token, });
     Future<AuthData> changePassword({required String token, required String password,});
     Future<AuthData> createNotification({required String token,required String title,required String content});
     Future<AuthData> createAnnouncement({required String token,required String videoLink,required String content,  File? thumbnail});



 }