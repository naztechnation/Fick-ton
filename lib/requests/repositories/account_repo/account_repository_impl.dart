
import '../../../model/auth_model/login.dart';
import '../../../res/app_strings.dart';
import '../../setup/requests.dart';
import 'account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<AuthData> registerUser(
      {required String email,
      required String password,
      required String gender,
      
      required String phone}) async {
    final map = await Requests().post(AppStrings.registerUrl, body: {
      "email": email,
      "password": password,
      "gender": gender,
      "phone": phone,
      "subscribed_users": 'subscribed_users',
      
    });
    return AuthData.fromJson(map);
  }
  
  @override
  Future<AuthData> loginUser({required String email, required String password}) async {
    final map = await Requests().post(AppStrings.loginUrl, body: {
      "email": email,
      "password": password,
      
    });
    return AuthData.fromJson(map);
  }


  @override
  Future<AuthData> verifyCode(
      {required String code, required String token,}) async {
    final map =
        await Requests().post(AppStrings.verifyCodeUrl, body: {
      "code": code,
      "token": token,
    });

    return AuthData.fromJson(map);
  }
  
  @override
  Future<AuthData> forgetPassword({required String email}) async {
    final map = await Requests().post(AppStrings.forgotPasswordUrl, body: {
      "email": email,
      
    });
    return AuthData.fromJson(map);
  }

   @override
  Future<AuthData> resetPassword(
      {required String token, required String password,}) async {
    final map =
        await Requests().post(AppStrings.resetPasswordUrl, body: {
      "token": token,
      "password": password,
    });

    return AuthData.fromJson(map);
  }
}
