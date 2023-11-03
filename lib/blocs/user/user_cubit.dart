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
  }) async {
    try {
      emit(CreatePostLoading());

      final agents = await userRepository.createPost(
        title: title,
        url: url,
        token: token,
        postId: postId,
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

  Future<void> getPost({required String url}) async {
    try {
      emit(PostListsLoading());

      final posts = await userRepository.getAllPosts(url: url);

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

   Future<void> getDraftPost({required String url}) async {
    try {
      emit(DraftLoading());

      final posts = await userRepository.getAllPosts(url: url);

      await viewModel.setDraftPostLists(posts: posts);

      emit(DraftLoaded(posts));
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

   Future<void> getFilteredPost({required String token, required String genre, required String filterParams,required String type}) async {
    try {
      emit(PostListsLoading());

      final posts = await userRepository.filterPost(token: token, genre: genre, filterParams: filterParams, type: type);

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

  Future<void> getPostDetails(
      {required String token, required String postId}) async {
    try {
      emit(PostDetailsLoading());

      final postsDetails = await userRepository.getPostsDetails(
        token: token,
        postId: postId,
      );

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

      final comments = await userRepository.createComment(
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

  Future<void> likeBookMark({
    required String token,
    required String postId,
    required String url,
  }) async {
    try {
      emit(LikeBookmarkLoading());

      final comments = await userRepository.likeBookmark(
        token: token,
        postId: postId,
        url: url,
      );

      emit(LikeBookmarkLoaded(comments));
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

  Future<void> bookmarkList({
    required String token,
  }) async {
    try {
      emit(BookmarkListLoading());

      final bookmarkList = await userRepository.bookmarkList(
        token: token,
      );

      emit(BookmarkListLoaded(bookmarkList));
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

  Future<void> createNotification({
    required String title,
    required String token,
    required String content,
  }) async {
    try {
      emit(CreatePostLoading());

      final agents = await userRepository.createNotification(
        title: title,
        token: token,
        content: content,
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
Future<void> createAnnouncement({
      File? thumbnail,
    required String token,
    required String content,
    required String videoLink,
  }) async {
    try {
      emit(CreatePostLoading());

      final agents = await userRepository.createAnnouncement(
        thumbnail: thumbnail,
        token: token,
        content: content, videoLink: videoLink,
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
  Future<void> deletePost(
      {required String token, required String postId, required String url,required String pin}) async {
    try {
      emit(DeletePostLoading());

      final post = await userRepository.deletePost(
        token: token,
        postId: postId,
        url: url,
         
      );

      emit(DeletePostLoaded(post));
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

   Future<void> deletePinPost(
      {required String token, required String postId, required String url, }) async {
    try {
      emit(DeletePostLoading());

      final post = await userRepository.deletePinPost(
        token: token,
        postId: postId,
        url: url,
         
      );

      emit(DeletePostLoaded(post));
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

   Future<void> dashboardAnalysis(
      {required String token, }) async {
    try {
      emit(AdminAnalysisLoading());

      final analysis = await userRepository.dashboardAnalysis(
        token: token,
        
      );

      emit(AdminAnalysisLoaded(analysis));
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

   Future<void> getNotifications(
      {required String token, }) async {
    try {
      emit(NotificationsLoading());

      final notifications = await userRepository.getNotifications(
        token: token,
        
      );

      emit(NotificationsLoaded(notifications));
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

   Future<void> deleteNotifications(
      {required String token, required notifyId}) async {
    try {
      emit(DelNotificationsLoading());

      final notifications = await userRepository.deleteNotification(
        token: token,
        notifyId: notifyId
      );

      emit(DelNotificationsLoaded(notifications));
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

  Future<void> changePassword(
      {required String token, required password}) async {
    try {
      emit(ChangePasswordLoading());

      final notifications = await userRepository.changePassword(
        token: token,
        password: password
      );

      emit(ChangePasswordLoaded(notifications));
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
