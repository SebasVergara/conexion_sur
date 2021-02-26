import 'package:flutter_share/flutter_share.dart';

class Share {
  static Future<void> shareNews(String name, String url) async {
    var postURL = 'https://www.conexionsur.co/post/' + url;
    await FlutterShare.share(
      title: name,
      text: name,
      linkUrl: postURL,
    );
  }
  static Future<void> shareBroadcast(String name, String url) async {
    var postURL = 'https://www.youtube.com/watch?v=' + url;
    await FlutterShare.share(
      title: name,
      text: name,
      linkUrl: postURL,
    );
  }
}