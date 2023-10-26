class NotificationData {
  int? status;
  String? message;
  List<Notifications>? data;

  NotificationData({this.status, this.message, this.data});

  NotificationData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Notifications>[];
      json['data'].forEach((v) {
        data!.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? id;
  String? title;
  String? content;
  String? type;
  String? createdAt;

  Notifications({this.id, this.title, this.content, this.type, this.createdAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    return data;
  }
}
