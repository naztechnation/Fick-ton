class CommentData {
  int? status;
  String? message;
  List<Comments>? data;

  CommentData({this.status, this.message, this.data});

  CommentData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Comments>[];
      json['data'].forEach((v) {
        data!.add(Comments.fromJson(v));
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

class Comments {
  String? id;
  String? userId;
  String? comment;
  String? postId;
  String? createdAt;
  String? email;

  Comments({this.id, this.userId, this.comment, this.postId, this.createdAt, this.email});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    comment = json['comment'];
    postId = json['post_id'];
    createdAt = json['created_at'];
     email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['comment'] = comment;
    data['post_id'] = postId;
    data['created_at'] = createdAt;
    data['email'] = email;
    
    return data;
  }
}
