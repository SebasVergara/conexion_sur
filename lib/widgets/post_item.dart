import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:conexionsur/models/post.dart';
import 'cached_image.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:
//                  Image.asset(
//                    'assets/images/placeholder.jpg',
//                    width: 100,
//                    height: 85,
//                    fit: BoxFit.cover,
//                  ),
                  CachedImage(
                    post.featuredImage.toString(),
                    width: 100,
                    height: 85,
                    fit: BoxFit.fitHeight,
                    align: Alignment.bottomRight,
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 85.0,
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
                        style: Theme.of(context)
                            .textTheme
                            .headline5,
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
                                style: TextStyle(fontSize: 11.0, color: Theme.of(context).accentColor),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 20.0))
      ],
    );
  }
}
