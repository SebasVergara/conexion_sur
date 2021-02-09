import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:conexionsur/models/post.dart';
import 'package:conexionsur/pages/news.dart';
import 'cached_image.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => News(post))),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xCCFFFFFF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFdbe2fb).withOpacity(0.7),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 6), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: Hero(
                        tag: post.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedImage(
                            post.featuredImage.toString(),
                            width: 100,
                            height: 95,
                            fit: BoxFit.fitHeight,
                            align: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 95.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
//                        "This is an example of titles for the list",
                                post.title,
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        MdiIcons.calendarMonthOutline,
                                        size: 18.0,
                                        color: Theme.of(context).accentColor,
                                      ),
                                      Text(
                                        post.date,
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            color: Theme.of(context).accentColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
