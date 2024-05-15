class CommentData {
    CommentData({
        required this.status,
        required this.message,
        required this.data,
    });

    final int? status;
    final String? message;
    final List<Datum> data;

    CommentData copyWith({
        int? status,
        String? message,
        List<Datum>? data,
    }) {
        return CommentData(
            status: status ?? this.status,
            message: message ?? this.message,
            data: data ?? this.data,
        );
    }

    factory CommentData.fromJson(Map<String, dynamic> json){ 
        return CommentData(
            status: json["status"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$status, $message, $data, ";
    }
}

class Datum {
    Datum({
        required this.id,
        required this.userId,
        required this.comment,
        required this.postId,
        required this.replyToId,
        required this.createdAt,
        required this.email,
        required this.replies,
    });

    final String? id;
    final String? userId;
    final String? comment;
    final String? postId;
    final String? replyToId;
    final String? createdAt;
    final String? email;
    final List<Comments> replies;

    Datum copyWith({
        String? id,
        String? userId,
        String? comment,
        String? postId,
        String? replyToId,
        String? createdAt,
        String? email,
        List<Comments>? replies,
    }) {
        return Datum(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            comment: comment ?? this.comment,
            postId: postId ?? this.postId,
            replyToId: replyToId ?? this.replyToId,
            createdAt: createdAt ?? this.createdAt,
            email: email ?? this.email,
            replies: replies ?? this.replies,
        );
    }

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            userId: json["user_id"],
            comment: json["comment"],
            postId: json["post_id"],
            replyToId: json["reply_to_id"],
            createdAt: json["created_at"],
            email: json["email"],
            replies: json["replies"] == null ? [] : List<Comments>.from(json["replies"]!.map((x) => Comments.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "comment": comment,
        "post_id": postId,
        "reply_to_id": replyToId,
        "created_at": createdAt,
        "email": email,
        "replies": replies.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$id, $userId, $comment, $postId, $replyToId, $createdAt, $email, $replies, ";
    }
}

class Comments {
    Comments({
        required this.id,
        required this.userId,
        required this.comment,
        required this.postId,
        required this.replyToId,
        required this.createdAt,
        required this.email,
    });

    final String? id;
    final String? userId;
    final String? comment;
    final String? postId;
    final String? replyToId;
    final String? createdAt;
    final String? email;

    Comments copyWith({
        String? id,
        String? userId,
        String? comment,
        String? postId,
        String? replyToId,
        String? createdAt,
        String? email,
    }) {
        return Comments(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            comment: comment ?? this.comment,
            postId: postId ?? this.postId,
            replyToId: replyToId ?? this.replyToId,
            createdAt: createdAt ?? this.createdAt,
            email: email ?? this.email,
        );
    }

    factory Comments.fromJson(Map<String, dynamic> json){ 
        return Comments(
            id: json["id"],
            userId: json["user_id"],
            comment: json["comment"],
            postId: json["post_id"],
            replyToId: json["reply_to_id"],
            createdAt: json["created_at"],
            email: json["email"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "comment": comment,
        "post_id": postId,
        "reply_to_id": replyToId,
        "created_at": createdAt,
        "email": email,
    };

   
}
