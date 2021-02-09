import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:conexionsur/widgets/cached_image.dart';
import 'package:conexionsur/models/post.dart';

class News extends StatelessWidget {
  Post post;

  News(this.post);

  @override
  Widget build(BuildContext context) {
    List<Widget> newsContent = new List<Widget>();
    for (int i = 0; i < post.postContent.length; i++) {
      if (post.postContent[i]['text'].toString().length > 1) {
        newsContent.add(newsText(post.postContent[i]['text']));
      }
      List<dynamic> entity = post.postContent[i]['entityRanges'];
      if (entity.length > 0) {
        if (entity[0]['key'].toString() == "0") {
          if (post.postImages[entity[0]['key'].toString()]["data"]["src"] != null) {
            newsContent.add(newsImage(StaticImage(post.postImages[entity[0]['key'].toString()]["data"]["src"]['file_name']).generateURL(), context));
          }
        }
        if (entity[0]['key'].toString() != "0") {
          if (post.postImages[entity[0]['key'].toString()]["data"]["items"] != null) {
            newsContent.add(newsGalleryImage(entity, post.postImages[entity[0]['key'].toString()]["data"]["items"], context));
//            for (int i = 0; i < post.postImages[entity[0]['key'].toString()]["data"]["items"].length; i++) {
//              newsContent.add(newsImage(StaticImage(post.postImages[entity[0]['key'].toString()]["data"]["items"][i]['url']).generateURL(), context));
//            }
          } else if (post.postImages[entity[0]['key'].toString()]["data"]["src"] != null) {
            newsContent.add(newsImage(StaticImage(post.postImages[entity[0]['key'].toString()]["data"]["src"]['file_name']).generateURL(), context));
          }

        }
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
  //          SliverAppBar(
  //            title: null,
  //            actions: [],
  //            leading: null,
  //            toolbarHeight: 20.0,
  //            floating: false,
  //            pinned: true,
  //            shadowColor: Colors.transparent,
  //            bottom: PreferredSize(
  //              child: Text('f'),
  //            ),
  ////            expandedHeight: 200,
  //            flexibleSpace: FlexibleSpaceBar(
  ////              background: Hero(
  ////                tag: post.id,
  ////                child: CachedImage(
  ////                  post.featuredImage.toString(),
  ////                  width: 100,
  ////                  height: 95,
  ////                  fit: BoxFit.fitWidth,
  ////                  align: Alignment.center,
  ////                ),
  ////              ),
  //            ),
  //          ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(padding: EdgeInsets.symmetric(vertical: 35.0))
                    ]
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    newsContent,
                  ),
                )
              ],
            ),
            Positioned(
              left: 10,
              top: 10,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF0045ba),
                child: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget newsText(text) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 12.0),
          child: Text(
            text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
        ),
      ],
    );
  }
  Widget newsImage(url, context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: CachedImage(url, width: MediaQuery.of(context).size.width,),
        ),

      ],
    );
  }
  Widget newsGalleryImage(entity, gallery, context) {
    List imgList = [];
    for (int i = 0; i < post.postImages[entity[0]['key'].toString()]["data"]["items"].length; i++) {
      imgList.add(StaticImage(post.postImages[entity[0]['key'].toString()]["data"]["items"][i]['url']).generateURL());
    }
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 3),
      ),
      items: imgList.map((imgUrl) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
