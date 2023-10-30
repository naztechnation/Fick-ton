

class AppStrings {
  static const String appName = 'FIK_KTON';
  
  static const String interSans = 'InterSans';
  static const String urbanist = 'Urbanist';

  static const String networkErrorMessage = "Network error, try again later";



  /// Base
  static const String _baseUrl = 'https://fikkton.com.ng/api/';
  

  /// User Endpoints
  static const String loginUrl = '${_baseUrl}auth/login';
  static const String registerUrl = '${_baseUrl}auth/register';
  static const String verifyCodeUrl = '${_baseUrl}auth/verify_token';
  static const String createPost = '${_baseUrl}posts/create';
  static const String forgotPasswordUrl = '${_baseUrl}auth/forgot_password';
  static const String updatePost = '${_baseUrl}posts/update';
  static const String createComments = '${_baseUrl}comments/create';
  static const String likePost = '${_baseUrl}likes/create';
  static const String deleteLike = '${_baseUrl}likes/delete';
  static const String unLikePost = '${_baseUrl}likes/delete';
  static const String bookmarkPost = '${_baseUrl}book/create';
  static const String unBookmarkPost = '${_baseUrl}book/delete';
  static const  String deletePost = '${_baseUrl}posts/delete';
  static const  String deletePinned = '${_baseUrl}pin/delete';
  static const  String deleteNotification = '${_baseUrl}notify/delete';
  static const  String changePasswordUrl = '${_baseUrl}users/change_password';
  static const  String resetPasswordUrl = '${_baseUrl}auth/reset_password';
  static const  String createAnnouncementUrl= '${_baseUrl}pin/create';
  

  static const  String createNotificationUrl  = '${_baseUrl}notify/create';
  static   String dashBoardDetailsUrl(String token) => '${_baseUrl}analyses/total?token=$token';
  static   String getNotifications(String token) => '${_baseUrl}notify/index?token=$token';
  static   String bookmarkListUrl(String token) => '${_baseUrl}book/index?token=$token';
  static   String getPosts(String token) => '${_baseUrl}posts/index?token=$token';
  static   String getDashboardAnalysis(String token) => '${_baseUrl}analyses/total?token=$token';
  static   String getDraftedPosts(String token) => '${_baseUrl}posts/draft?token=$token';
  static   String getComments(String token, String post) => '${_baseUrl}comments/show?token=$token&post_id=$post';
  static   String getPostsDetails(String token,String postId) => '${_baseUrl}posts/show?post_id=$postId&token=$token';
  static   String filterPost(String token,String filterParams, String genre, String type) => '${_baseUrl}posts/filter?filter_by=$filterParams&genre=$genre&token=$token&type=$type';
}