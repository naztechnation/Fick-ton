import 'package:fikkton/model/posts/get_posts.dart';

class BookmarkList {
  int? status;
  String? message;
  List<Posts>? data;

  BookmarkList({this.status, this.message, this.data});

  BookmarkList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Posts>[];
      json['data'].forEach((v) {
        data!.add(  Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

