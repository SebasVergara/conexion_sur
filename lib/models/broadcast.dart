import 'package:intl/intl.dart';

class Broadcast {
  String title;
  String publishedAt;
  String thumbnail;
  String videoId;
  bool live;


  String get date => DateFormat('dd/MM/yy - h:mm a').format(DateTime.parse(this.publishedAt)).toString();

  Broadcast({this.title, this.publishedAt, this.thumbnail, this.videoId});

  Broadcast.fromJson(Map<String, dynamic> json) {
    title = json['snippet']['title'];
    publishedAt = json['snippet']['publishedAt'];
    thumbnail = json['snippet']['thumbnails']['medium']['url'];
    videoId = json.containsKey('contentDetails') ? json['contentDetails']['videoId'] : json['id']['videoId'];
    live = json['snippet'].containsKey('liveBroadcastContent') ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['publishedAt'] = this.publishedAt;
    data['thumbnail'] = this.thumbnail;
    data['videoId'] = this.videoId;
    data['live'] = this.live;
    return data;
  }
}
