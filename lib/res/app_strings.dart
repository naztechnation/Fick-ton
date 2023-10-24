

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
  static const String createComments = '${_baseUrl}comments/create';
  static   String getPosts(String token) => '${_baseUrl}posts/index?token=$token';
  static   String getComments(String token, String post) => '${_baseUrl}comments/show?token=$token&post_id=$post';
  static   String getPostsDetails(String token) => '${_baseUrl}posts/show?post_id=2&token=$token';
}