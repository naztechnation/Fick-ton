

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
  static   String getPosts(String token) => '${_baseUrl}posts/index?token=$token';
}