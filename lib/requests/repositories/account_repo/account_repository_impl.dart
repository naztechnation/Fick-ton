
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

  // @override
  

  // @override
  // Future<PetProfile> registerUserPetProfile(
  //     {required String username,
  //     required String type,
  //     required String petname,
  //     required String gender,
  //     required String breed,
  //     required String size,
  //     required String about,
  //     required String picture}) async {
  //   final map = await Requests()
  //       .post(AppStrings.registerUserPetProfileUrl(username: username), body: {
  //     "type": type,
  //     "name": petname,
  //     "gender": gender,
  //     "breed": breed,
  //     "size": size,
  //     "about": about,
  //     'picture': picture
  //   });
  //   return PetProfile.fromJson(map);
  // }

  // Future<AuthData> sendPetHealth(
  //     {required String name,
  //     required String drug,
  //     required String prescription,
  //     required String url}) async {
  //   final map = await Requests().post(AppStrings.petHealthUrl(url: url), body: {
  //     "name": name,
  //     "drug": drug,
  //     "prescription": prescription,
  //   });
  //   return AuthData.fromJson(map);
  // }

  // @override
  // Future<CreateAgents> registerServiceProviderProfile(
  //     {required String username,
  //     required String dob,
  //     required String name,
  //     required String gender,
  //     required String country,
  //     required String city,
  //     required String about,
  //     required String picture}) async {
  //   final map = await Requests().post(
  //       AppStrings.registerServiceProviderProfileUrl(username: username),
  //       body: {
  //         "date_of_birth": dob,
  //         "name": name,
  //         "gender": gender,
  //         "about": about,
  //         "country": country,
  //         "city": city,
  //         // 'picture':
  //         //     'https://static.standard.co.uk/s3fs-public/thumbnails/image/2019/03/15/17/pixel-dogsofinstagram-3-15-19.jpg?width=1200&height=1200&fit=crop'
  //         'picture': picture
  //       });
  //   return CreateAgents.fromJson(map);
  // }

  

  // Future<CreateAgents> servicePetNames(
  //     {required List<String> petnames,
  //     required String username,
  //     required String agentId}) async {
  //   final map =
  //       await Requests().patch(AppStrings.selectPetTypeUrl(agentId), body: {
  //     "pet_types": petnames,
  //   }, headers: {
  //     'Authorization': AppStrings.token,
  //     "Content-type": "application/json"
  //   });
  //   return CreateAgents.fromJson(map);
  // }

  // @override
  // Future<AuthData> resendCode({required String username}) async {
  //   final map = await Requests().get(AppStrings.otpUrl(username), headers: {
  //     'Authorization': AppStrings.token,
  //   });
  //   return AuthData.fromJson(map);
  // }

  

  // @override
  // Future<AuthData> uploadPhotoUrl(
  //     {required String agentId, required String photoUrl, required String idType}) async {
  //   final map = await Requests().patch(AppStrings.uploadIdUrl(agentId), body: {
  //     "id_photo": photoUrl,
  //     "id_type": idType,
  //   }, headers: {
  //     'Authorization': AppStrings.token,
  //     "Content-type": "application/json"
  //   });
  //   return AuthData.fromJson(map);
  // }
}
