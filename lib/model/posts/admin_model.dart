class DashBoardAnalysis {
  int? status;
  String? message;
  Admin? data;

  DashBoardAnalysis({this.status, this.message, this.data});

  DashBoardAnalysis.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Admin.fromJson(json['data']) : null;
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

class Admin {
  String? comments;
  String? users;
  String? posts;
  String? views;
  UsersAnalysis? usersAnalysis;
  UsersAnalysis? viewsAnalysis;

  Admin(
      {this.comments,
      this.users,
      this.posts,
      this.views,
      this.usersAnalysis,
      this.viewsAnalysis});

  Admin.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    users = json['users'];
    posts = json['posts'];
    views = json['views'];
    usersAnalysis = json['usersAnalysis'] != null
        ? new UsersAnalysis.fromJson(json['usersAnalysis'])
        : null;
    viewsAnalysis = json['viewsAnalysis'] != null
        ? new UsersAnalysis.fromJson(json['viewsAnalysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['users'] = this.users;
    data['posts'] = this.posts;
    data['views'] = this.views;
    if (this.usersAnalysis != null) {
      data['usersAnalysis'] = this.usersAnalysis!.toJson();
    }
    if (this.viewsAnalysis != null) {
      data['viewsAnalysis'] = this.viewsAnalysis!.toJson();
    }
    return data;
  }
}

class UsersAnalysis {
  int? jan;
  int? feb;
  int? mar;
  int? apr;
  int? may;
  int? jun;
  int? jul;
  int? aug;
  int? sep;
  int? oct;
  int? nov;
  int? dec;

  UsersAnalysis(
      {this.jan,
      this.feb,
      this.mar,
      this.apr,
      this.may,
      this.jun,
      this.jul,
      this.aug,
      this.sep,
      this.oct,
      this.nov,
      this.dec});

  UsersAnalysis.fromJson(Map<String, dynamic> json) {
    jan = json['Jan'];
    feb = json['Feb'];
    mar = json['Mar'];
    apr = json['Apr'];
    may = json['May'];
    jun = json['Jun'];
    jul = json['Jul'];
    aug = json['Aug'];
    sep = json['Sep'];
    oct = json['Oct'];
    nov = json['Nov'];
    dec = json['Dec'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   Map<String, dynamic>();
    data['Jan'] = this.jan;
    data['Feb'] = this.feb;
    data['Mar'] = this.mar;
    data['Apr'] = this.apr;
    data['May'] = this.may;
    data['Jun'] = this.jun;
    data['Jul'] = this.jul;
    data['Aug'] = this.aug;
    data['Sep'] = this.sep;
    data['Oct'] = this.oct;
    data['Nov'] = this.nov;
    data['Dec'] = this.dec;
    return data;
  }
}
