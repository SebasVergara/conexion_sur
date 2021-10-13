import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:conexionsur/models/broadcast.dart';
import 'package:conexionsur/models/category.dart';
import 'package:conexionsur/models/post.dart';

import '../globals.dart' as globals;

import '../constants.dart';

class API {
  static const String BASE_URL = URL + REST_URL_PREFIX;
  
  static const String AUTH_TOKEN = "qGb0HqStUM1fRqki_RzYnIgzW7SSWZwCB5iMgi_a2qU.eyJpbnN0YW5jZUlkIjoiZGIwNWQyYzAtMWVlOC00YzQ1LWI2YjUtODkyM2EzOTEzZTg2IiwiYXBwRGVmSWQiOiIxNGJjZGVkNy0wMDY2LTdjMzUtMTRkNy00NjZjYjNmMDkxMDMiLCJtZXRhU2l0ZUlkIjoiODlhOTgxNzEtYWI4YS00YjljLWFmNjYtMGU2Y2MwOWUxYTRhIiwic2lnbkRhdGUiOiIyMDIxLTAxLTI4VDE1OjE3OjU4LjI5OFoiLCJkZW1vTW9kZSI6ZmFsc2UsIm9yaWdpbkluc3RhbmNlSWQiOiI5ZmU1NzVjMC04M2RmLTQ5YTQtYjEyMi03N2MxZWM1NTVjNTciLCJhaWQiOiI5NjY1YWFiMC01NzE1LTQ0Y2YtOTY4Yy03ODk3NjcyYzU2NmEiLCJiaVRva2VuIjoiNTJhYzUzYjEtYjU2Mi0wN2Q5LTE5ZDMtODc0ZjYzMGYyNGNjIiwic2l0ZU93bmVySWQiOiI0NzVkN2ZjOS1kMWZmLTQxY2QtOWU0Ni0wZWY3ODNkNTA4MzYifQ";

  static Future<List<Broadcast>> getBroadcastList() async {
    List<Broadcast> broadcast = List();
    try {

      dynamic response = await http.get(VIDEO_URL);
      dynamic json = jsonDecode(response.body)['items'];

      (json as List).forEach((v) {
        broadcast.add(Broadcast.fromJson(v));
      });
    } catch (e) {
      print(e);
      //TODO Handle No Internet Response
    }
    return broadcast;
  }

  static Future<List<Category>> getCategories() async {
    List<Category> list = [];

    try {

      dynamic response = await http.get(BASE_URL + "/communities-blog-node-api/_api/categories?offset=0&size=500", headers: {"Authorization": globals.authToken});
      dynamic json = jsonDecode(response.body);

      (json as List).forEach((v) {
        list.add(Category.fromJson(v));
      });
    } catch (e) {
      print(e);
      //TODO Handle No Internet Response
    }
    return list;
  }

  static Future<List<Post>> getPosts({String category = '0', int page = 1}) async {
    List<Post> list = [];
    int offset = page * 10;
    try {
      String extra = category != '0' ? '&categoryIds=' + '$category' : '';

      dynamic response = await http.get(BASE_URL + "/communities-blog-node-api/_api/posts?size=10&offset=$offset" + extra, headers: {"Authorization": globals.authToken});
      dynamic json = jsonDecode(response.body);

      (json as List).forEach((v) {
        list.add(Post.fromJson(v));
      });
    } catch (e) {
      print(e);
      //TODO Handle No Internet Response
    }
    return list;
  }

  static Future<Post> getPost({String slug = '0'}) async {
    Post news;
    try {

      dynamic response = await http.get(BASE_URL + "/communities-blog-node-api/_api/posts/content/$slug", headers: {"Authorization": globals.authToken});
      dynamic json = jsonDecode(response.body);

      news = Post.fromJson(json);

    } catch (e) {
      print(e);
      //TODO Handle No Internet Response
    }
    print(news.title);
    return news;
  }

  static Future<dynamic> fetchAuthToken() async {
    final response = await http.get(URL + '_api/v2/dynamicmodel');

    if (response.statusCode == 200) {
      globals.authToken = jsonDecode(response.body)['apps']['139ef4fa-c108-8f9a-c7be-d5f492a2c939']['instance'];
      return (jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  static Future<List<Broadcast>> getBroadcastLive() async {
    List<Broadcast> broadcast = List();
    try {

      dynamic response = await http.get(LIVE_URL);
      dynamic json = jsonDecode(response.body)['items'];

      (json as List).forEach((v) {
        broadcast.add(Broadcast.fromJson(v));
      });
    } catch (e) {
      print(e);
      //TODO Handle No Internet Response
    }
    return broadcast;
  }
  static Future<Broadcast> getBroadcast({String id = '0'}) async {
    Broadcast broadcast;
    try {

      dynamic response = await http.get("https://youtube.googleapis.com/youtube/v3/videos?part=id%2C%20snippet%2C%20contentDetails&id=$id&maxResults=1&key={{API_KEY}}");
      dynamic json = jsonDecode(response.body)['items'][0];
      print('broadcast1');
      print(json);
      broadcast = Broadcast.fromJson(json);
      print('broadcast2');

    } catch (e) {
      print(e);
      //TODO Handle No Internet Response
    }
    print(broadcast);
    return broadcast;
  }
}
