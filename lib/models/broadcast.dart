import 'package:intl/intl.dart';

class Broadcast {
  String title;
  String publishedAt;
  String thumbnail;
  String videoId;

  String get date => DateFormat('dd/MM/yy - h:mm a').format(DateTime.parse(this.publishedAt)).toString();

  Broadcast({this.title, this.publishedAt, this.thumbnail, this.videoId});

  Broadcast.fromJson(Map<String, dynamic> json) {
    title = json['snippet']['title'];
    publishedAt = json['snippet']['publishedAt'];
    thumbnail = json['snippet']['thumbnails']['medium']['url'];
    videoId = json['contentDetails']['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['publishedAt'] = this.publishedAt;
    data['thumbnail'] = this.thumbnail;
    data['videoId'] = this.videoId;
    return data;
  }
}
