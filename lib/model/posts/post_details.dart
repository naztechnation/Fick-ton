class PostDetails {
  int? status;
  String? message;
  Data? data;

  PostDetails({this.status, this.message, this.data});

  PostDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
  String? views;
  String? likes;
  String? createdAt;
  String? updatedAt;
  String? status;
  String? isBooked;
  String? isLiked;

  Data(
      {this.id,
      this.title,
      this.content,
      this.thumbnail,
      this.videoLink,
      this.author,
      this.genre,
      this.isTrending,
      this.views,
      this.likes,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.isBooked,
      this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    videoLink = json['video_link'];
    author = json['author'];
    genre = json['genre'];
    isTrending = json['is_trending'];
    views = json['views'];
    likes = json['likes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    isBooked = json['is_booked'];
    isLiked = json['is_liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['video_link'] = this.videoLink;
    data['author'] = this.author;
    data['genre'] = this.genre;
    data['is_trending'] = this.isTrending;
    data['views'] = this.views;
    data['likes'] = this.likes;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['is_booked'] = this.isBooked;
    data['is_liked'] = this.isLiked;
    return data;
  }
}
