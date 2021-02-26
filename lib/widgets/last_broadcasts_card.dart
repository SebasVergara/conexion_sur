import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:conexionsur/models/broadcast.dart';
import 'package:conexionsur/pages/broadcast.dart';

import 'cached_image.dart';

class LastBroadcastsCard extends StatefulWidget {
  final Broadcast broadcast;

  LastBroadcastsCard(this.broadcast);

  @override
  _LastBroadcastsCardState createState() => _LastBroadcastsCardState();
}

class _LastBroadcastsCardState extends State<LastBroadcastsCard> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation =  Tween(begin: 2.0,end: 12.0).animate(_animationController)..addListener((){
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFdbe2fb).withOpacity(0.7),
                  spreadRadius: 3,
                  blurRadius: 8,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            height: 250.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () => {
                    FirebaseAnalytics().logEvent(name: 'open_broadcast',parameters: {'News':widget.broadcast.title}),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoBroadcast(widget.broadcast),
                        settings: RouteSettings(name: 'VideoBroadcast'),
                      )
                    )
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 160.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: AspectRatio(
                          aspectRatio: 5 / 3,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              CachedImage(widget.broadcast.thumbnail),
                              if(widget.broadcast.live == true)
                                Positioned(
                                  right: 10,
                                  top: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [BoxShadow(
                                        color: Color.fromARGB(130, 237, 125, 58),
                                        blurRadius: _animation.value,
                                        spreadRadius: _animation.value
                                      )],

                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                                    child: Text(
                                      "En vivo",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                ),
                            ],
//                            child: CachedImage(broadcast.thumbnail)
                          ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 90.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0, bottom: 16.0),
                        child: AutoSizeText(
                          widget.broadcast.title,
                          style: Theme.of(context).textTheme.headline3,
                          maxLines: 2,
                          minFontSize: 16,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
