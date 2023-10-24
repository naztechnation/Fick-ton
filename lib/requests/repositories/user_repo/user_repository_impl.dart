import 'dart:io';

import 'package:fikkton/model/auth_model/login.dart';
import 'package:fikkton/model/posts/get_posts.dart';

import '../../../model/posts/comment_lists.dart';
import '../../../model/posts/post_details.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
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
  }) async {
    final map = await Requests().post(
      AppStrings.createPost,
      files: {'thumbnail': thumbnail},
      body: {
        "title": title,
        "token": token,
        "content": content,
        "video_link": videoLink,
        "genre": genre,
        "author": author,
        "status": status,
        "trending": trending,
      },
    );
    return AuthData.fromJson(map);
  }

  @override
  Future<GetAllPosts> getAllPosts({required String token}) async {
    final map = await Requests().get(AppStrings.getPosts(token));

    return GetAllPosts.fromJson(map);
  }

  @override
  Future<PostDetails> getPostsDetails({required String token}) async {
    final map = await Requests().get(AppStrings.getPostsDetails(token));

    return PostDetails.fromJson(map);
  }

  @override
  Future<AuthData> addComment(
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

    return AuthData.fromJson(map);
  }

  @override
  Future<CommentData> getComment({required String token, required String postId}) async {
    final map = await Requests().get(AppStrings.getComments(token,postId));

    return CommentData.fromJson(map);
  }
}