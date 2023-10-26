import 'package:equatable/equatable.dart';
import 'package:fikkton/model/auth_model/login.dart';
import 'package:fikkton/model/posts/bookmark_lists.dart';
import 'package:fikkton/model/posts/comment_lists.dart';
import 'package:fikkton/model/posts/get_posts.dart';
import 'package:fikkton/model/posts/post_details.dart';

// import '../../model/account_models/agents_packages.dart';
// import '../../model/account_models/confirm_payment.dart';
// import '../../model/user_models/gallery_data.dart';
// import '../../model/user_models/reviews_data.dart';
// import '../../model/user_models/service_provider_lists.dart';
// import '../../model/user_models/service_type.dart';

abstract class UserStates extends Equatable {
  const UserStates();
}

class InitialState extends UserStates {
  const InitialState();
  @override
  List<Object> get props => [];
}

class CreatePostLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CreatePostLoaded extends UserStates {
  final AuthData createPost;
  const CreatePostLoaded(this.createPost);
  @override
  List<Object> get props => [createPost];
}

class PostListsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class LikeBookmarkLoading extends UserStates {
  @override
  List<Object> get props => [];
}
class LikeBookmarkLoaded extends UserStates {
  final AuthData createPost;
  const LikeBookmarkLoaded(this.createPost);
  @override
  List<Object> get props => [createPost];
}

class BookmarkListLoading extends UserStates {
  @override
  List<Object> get props => [];
}
class BookmarkListLoaded extends UserStates {
  final BookmarkList bookmarkList;
  const BookmarkListLoaded(this.bookmarkList);
  @override
  List<Object> get props => [bookmarkList];
}





class PostListsLoaded extends UserStates {
  final GetAllPosts postLists;
  const PostListsLoaded(this.postLists);
  @override
  List<Object> get props => [postLists];
}


class PostDetailsLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class PostDetailsLoaded extends UserStates {
  final PostDetails postDetails ;
  const PostDetailsLoaded(this.postDetails);
  @override
  List<Object> get props => [postDetails];
}

class CreateCommentLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CreateCommentLoaded extends UserStates {
  final AuthData postComment ;
  const CreateCommentLoaded(this.postComment);
  @override
  List<Object> get props => [postComment];
}

class CommentLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class CommentLoaded extends UserStates {
  final CommentData postComment ;
  const CommentLoaded(this.postComment);
  @override
  List<Object> get props => [postComment];
}


class DeletePostLoading extends UserStates {
  @override
  List<Object> get props => [];
}

class DeletePostLoaded extends UserStates {
  final AuthData deletePost ;
  const DeletePostLoaded(this.deletePost);
  @override
  List<Object> get props => [deletePost];
}

class UserNetworkErr extends UserStates {
  final String? message;
  const UserNetworkErr(this.message);
  @override
  List<Object> get props => [message!];
}

class UserNetworkErrApiErr extends UserStates {
  final String? message;
  const UserNetworkErrApiErr(this.message);
  @override
  List<Object> get props => [message!];
}



