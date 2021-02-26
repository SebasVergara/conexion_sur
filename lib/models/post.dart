import 'package:intl/intl.dart';

class Post {
  String id;
  String title;
  String createdDate;
  String featuredImage;
  List<dynamic> postContent;
  dynamic postImages;

  String get date => DateFormat('dd/MM/yy - h:mm a').format(DateTime.parse((this.createdDate).replaceAll('Z', '+05:00'))).toString();

  Post({
    this.id,
    this.title,
    this.createdDate,
    this.featuredImage,
    this.postContent,
    this.postImages
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    createdDate = json['createdDate'];
    featuredImage = StaticImage(json['content']['entityMap']["0"]['data']['src']['file_name']).generateURL();
    postContent = json['content']['blocks'];
    postImages = json['content']['entityMap'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['createdDate'] = this.createdDate;
    data['featuredImage'] = this.featuredImage;
    data['postContent'] = this.postContent;
    data['postImages'] = this.postImages;
    return data;
  }

}

class StaticImage {
  String url;
  StaticImage(this.url);

  generateURL() {
    var staticUrl;
    staticUrl = "https://static.wixstatic.com/media/" + url + "/v1/fit/w_450,h_450,al_c,q_5/file.png";
    return staticUrl;
  }
}


