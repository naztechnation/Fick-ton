class AuthData {
  int? status;
  String? message;
  String? token;
  UserData? data;

  AuthData({this.status, this.message, this.token, this.data});

  AuthData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? phone;
  String? gender;
  String? isAdmin;
  String? status;

  UserData({this.phone, this.gender, this.isAdmin, this.status});

  UserData.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    gender = json['gender'];
    isAdmin = json['is_admin'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['is_admin'] = this.isAdmin;
    data['status'] = this.status;
    return data;
  }
}
