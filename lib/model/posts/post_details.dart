class PostDetails {
  int? status;
  String? message;
  Data? data;

  PostDetails({this.status, this.message, this.data});

  PostDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? content;
  String? thumbnail;
  String? videoLink;
  String? author;
  String? genre;
  String? isTrending;
  String? createdAt;
  String? updatedAt;
  String? status;

  Data(
      {this.id,
      this.title,
      this.content,
      this.thumbnail,
      this.videoLink,
      this.author,
      this.genre,
      this.isTrending,
      this.createdAt,
      this.updatedAt,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    videoLink = json['video_link'];
    author = json['author'];
    genre = json['genre'];
    isTrending = json['is_trending'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['thumbnail'] = thumbnail;
    data['video_link'] = videoLink;
    data['author'] = author;
    data['genre'] = genre;
    data['is_trending'] = isTrending;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    return data;
  }
}
