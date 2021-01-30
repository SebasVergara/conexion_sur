import 'package:intl/intl.dart';

class Post {
  String id;
  String title;
  String createdDate;
  String featuredImage;

  String get date => DateFormat('dd/MM/yy - h:mm a').format(DateTime.parse(this.createdDate)).toString();

  Post({
    this.id,
    this.title,
    this.createdDate,
    this.featuredImage
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    createdDate = json['createdDate'];
    featuredImage = "https://static.wixstatic.com/media/" + json['content']['entityMap']["0"]['data']['src']['file_name'] + "/v1/fit/w_150,h_150,al_c,q_5/file.png";
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['featuredImage'] = this.featuredImage;
    return data;
  }

}

