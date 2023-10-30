class GetAllPosts {
  int? status;
  String? message;
  PostData? data;

  GetAllPosts({this.status, this.message, this.data});

  GetAllPosts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PostData.fromJson(json['data']) : null;
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

class PostData {
  List<Posts>? posts;
  List<String>? genres;
  List<String>? filterBy;
   List<String>? type;
  List<Pinned>? pinned;

  PostData({this.posts, this.genres, this.filterBy});

  PostData.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
    genres = json['genres'].cast<String>();
    filterBy = json['filter_by'].cast<String>();
    type = json['type'].cast<String>();
    if (json['pinned'] != null) {
      pinned = <Pinned>[];
      json['pinned'].forEach((v) {
        pinned!.add(new Pinned.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['genres'] = this.genres;
    data['filter_by'] = this.filterBy;
    data['type'] = this.type;
    if (this.pinned != null) {
      data['pinned'] = this.pinned!.map((v) => v.toJson()).toList();
    }
    return data;
  }
   
  }

class Pinned {
  String? id;
  String? content;
  String? thumbnail;
  String? videoLink;
  String? author;
  String? status;
  String? createdAt;
  String? updatedAt;

  Pinned(
      {this.id,
      this.content,
      this.thumbnail,
      this.videoLink,
      this.author,
      this.status,
      this.createdAt,
      this.updatedAt});

  Pinned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    thumbnail = json['thumbnail'];
    videoLink = json['video_link'];
    author = json['author'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['video_link'] = this.videoLink;
    data['author'] = this.author;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Posts {
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

  Posts(
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
      this.isBooked});

  Posts.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
