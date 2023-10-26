

class AppStrings {
  static const String appName = 'FIK_KTON';
  
  static const String interSans = 'InterSans';
  static const String montserrat = 'Montserrat';

  static const String networkErrorMessage = "Network error, try again later";



  /// Base
  static const String _baseUrl = 'https://fikkton.com.ng/api/';
  

  /// User Endpoints
  static const String loginUrl = '${_baseUrl}auth/login';
  static const String registerUrl = '${_baseUrl}auth/register';
  static const String verifyCodeUrl = '${_baseUrl}auth/verify_token';
  static const String createPost = '${_baseUrl}posts/create';
  static const String updatePost = '${_baseUrl}posts/update';
  static const String createComments = '${_baseUrl}comments/create';
  static const String likePost = '${_baseUrl}likes/create';
  static const String unLikePost = '${_baseUrl}likes/delete';
  static const String bookmarkPost = '${_baseUrl}book/create';
  static const String unBookmarkPost = '${_baseUrl}book/delete';
  static const  String deletePost = '${_baseUrl}posts/delete';

  static const  String createNotificationUrl  = '${_baseUrl}notify/create';
  static   String dashBoardDetailsUrl(String token) => '${_baseUrl}analyses/total?token=';
  static   String bookmarkListUrl(String token) => '${_baseUrl}book/index?token=$token';
  static   String getPosts(String token) => '${_baseUrl}posts/index?token=$token';
  static   String getDraftedPosts(String token) => '${_baseUrl}posts/draft?token=$token';
  static   String getComments(String token, String post) => '${_baseUrl}comments/show?token=$token&post_id=$post';
  static   String getPostsDetails(String token,String postId) => '${_baseUrl}posts/show?post_id=$postId&token=$token';
}