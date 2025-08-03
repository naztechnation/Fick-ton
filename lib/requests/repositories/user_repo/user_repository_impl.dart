import 'dart:io';

import 'package:fikkton/model/auth_model/login.dart';
import 'package:fikkton/model/posts/admin_model.dart';
import 'package:fikkton/model/posts/get_posts.dart';
import 'package:fikkton/model/posts/notification_model.dart';

import '../../../model/posts/bookmark_lists.dart';
import '../../../model/posts/comment_lists.dart';
import '../../../model/posts/post_details.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<AuthData> createPost({
    required String title,
    required String url,
    required String postId,
    required String content,
    required File thumbnail,
    required File image1,
    required File image2,
    required String content2,
    required String genre,
    required String status,
    required String author,
    required String trending,
  }) async {
    final map = await Requests().post(
      url,
      files: {
        'thumbnail': thumbnail,
        'image1': image1,
        'image2': image2,
      },
      body: {
        "title": title,
        // "token": token,
        "content": content,
        "content2": content2,
        // "video_link": videoLink,
        "genre": genre,
        "author": author,
        "status": status,
        "trending": trending,
        "post_id": postId,
      },
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<GetAllPosts> getAllPosts({required String url}) async {
    final map = await Requests().get(url);

    return GetAllPosts.fromJson(map);
  }

  @override
  Future<PostDetails> getPostsDetails(
      {required String token, required String postId}) async {
    final map = await Requests().get(AppStrings.getPostsDetails(token, postId));

    return PostDetails.fromJson(map);
  }

  @override
  Future<CommentData> createComment(
      {required String token,
      required String postId,
      required String comment}) async {
    final map = await Requests().post(
      AppStrings.createComments,
      body: {
        "token": token,
        "comment": comment,
        "post_id": postId,
      },
    );

    return CommentData.fromJson(map);
  }

  @override
  Future<CommentData> getComment(
      {required String token, required String postId}) async {
    final map = await Requests().get(AppStrings.getComments(token, postId));

    return CommentData.fromJson(map);
  }

  @override
  Future<AuthData> likeBookmark(
      {required String token,
      required String postId,
      required String url}) async {
    final map = await Requests().post(
      url,
      body: {
        "token": token,
        "post_id": postId,
      },
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> createNotification(
      {required String token,
      required String title,
      required String content}) async {
    final map = await Requests().post(
      AppStrings.createNotificationUrl,
      body: {
        "token": token,
        "content": content,
        "title": title,
      },
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<BookmarkList> bookmarkList({
    required String token,
  }) async {
    final map = await Requests().get(AppStrings.bookmarkListUrl(token));

    return BookmarkList.fromJson(map);
  }

  @override
  Future<AuthData> deletePost({
    required String token,
    required String postId,
    required String url,
  }) async {
    final map = await Requests().post(
      url,
      body: {
        "token": token,
        "post_id": postId,
      },
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> deletePinPost({
    required String token,
    required String postId,
    required String url,
  }) async {
    final map = await Requests().post(
      url,
      body: {
        "token": token,
        "pin_id": postId,
      },
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<DashBoardAnalysis> dashboardAnalysis({required String token}) async {
    final map = await Requests().get(AppStrings.getDashboardAnalysis(token));

    return DashBoardAnalysis.fromJson(map);
  }

  @override
  Future<NotificationData> getNotifications({required String token}) async {
    final map = await Requests().get(AppStrings.getNotifications(token));

    return NotificationData.fromJson(map);
  }

  @override
  Future<AuthData> deleteNotification(
      {required String token, required String notifyId}) async {
    final map = await Requests().post(
      AppStrings.deleteNotification,
      body: {
        "token": token,
        "notify_id": notifyId,
      },
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<AuthData> changePassword(
      {required String token, required String password}) async {
    final map = await Requests().post(
      AppStrings.changePasswordUrl,
      body: {
        "token": token,
        "password": password,
      },
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<GetAllPosts> filterPost(
      {required String token,
      required String genre,
      required String filterParams,
      required String type}) async {
    final map = await Requests()
        .get(AppStrings.filterPost(token, filterParams, genre, type));

    return GetAllPosts.fromJson(map);
  }

  @override
  Future<AuthData> createAnnouncement(
      {required String token,
      required String videoLink,
      required String content,
      File? thumbnail}) async {
    final map = await Requests().post(
      AppStrings.createAnnouncementUrl,
      files: {'thumbnail': thumbnail ?? File('')},
      body: {
        "token": token,
        "content": content,
        "video_link": content,
      },
    );

    return AuthData.fromJson(map);
  }

  @override
  Future<GetAllPosts> deleteAccount({required String userId}) async {
    final map = await Requests().post(
      AppStrings.deleteUser,
      body: {
        "param": userId,
      },
    );

    return GetAllPosts.fromJson(map);
  }
}
