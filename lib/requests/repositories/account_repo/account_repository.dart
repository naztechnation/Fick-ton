

import '../../../model/auth_model/login.dart';

abstract class AccountRepository {
  Future<AuthData> registerUser({
    required String gender,
    
    required String email,required String password,required String phone,});

       Future<AuthData> loginUser({required String email,required String password,});
       Future<AuthData> verifyCode({required String code,required String token,});
       Future<AuthData> forgetPassword({required String email,});
       Future<AuthData> resetPassword({required String token, required String password,});

}