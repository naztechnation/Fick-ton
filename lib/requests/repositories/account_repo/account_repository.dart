

import '../../../model/auth_model/login.dart';

abstract class AccountRepository {
  Future<AuthData> registerUser({
    required String gender,
    
    required String email,required String password,required String phone,});

       Future<AuthData> loginUser({required String email,required String password,});
       Future<AuthData> verifyCode({required String code,required String token,});
//   Future<AuthData> sendPetHealth({required String name,required String drug,required String prescription,required String url});

//   Future<AuthData> logoutUser({required String username,required String password,});
//   Future<AuthData> resendCode({required String username,});
//   Future<AuthData> verifyUser({required String code,required String username,});
//   Future<AuthData> uploadPhotoUrl({required String agentId,required String photoUrl,required String idType});
//   Future<PetProfile> registerUserPetProfile({
//     required String username,
//     required String type,required String petname,required String gender,required String breed,required String size,required String about,required String picture});


// Future<CreateAgents> registerServiceProviderProfile({
//     required String username,
//     required String dob,required String name,required String gender,
//     required String country,required String city,required String about,required String picture});

//  Future<CreateAgents> servicePetNames({required List<String> petnames,required String username,required String agentId});   
}