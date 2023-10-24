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

  Future<void> createPost({
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

      await viewModel.setPostLists(posts: posts);

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

  Future<void> getPostDetails({
    required String token,
  }) async {
    try {
      emit(PostDetailsLoading());

      final postsDetails = await userRepository.getPostsDetails(
        token: token,
      );

      //  await viewModel.setPostLists(posts:posts);

      emit(PostDetailsLoaded(postsDetails));
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

  Future<void> createComment({
    required String token,
    required String postId,
    required String comment,
  }) async {
    try {
      emit(CreateCommentLoading());

      final comments = await userRepository.addComment(
        token: token,
        postId: postId,
        comment: comment,
      );

      emit(CreateCommentLoaded(comments));
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

  Future<void> getComment({
    required String token,
    required String postId,
  }) async {
    try {
      emit(CommentLoading());

      final comments = await userRepository.getComment(
        token: token,
        postId: postId,
      );

      emit(CommentLoaded(comments));
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
}
