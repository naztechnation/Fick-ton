class AuthData {
  int? status;
  String? message;
  String? token;

  AuthData({this.status, this.message, this.token});

  AuthData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}
