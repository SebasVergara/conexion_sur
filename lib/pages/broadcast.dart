import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'package:conexionsur/models/broadcast.dart';
import 'package:conexionsur/services/share.dart';

// ignore: must_be_immutable
class VideoBroadcast extends StatelessWidget {
  Broadcast broadcast;

  VideoBroadcast(this.broadcast);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: broadcast.videoId,
      params: YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );

    print(broadcast.live);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70.0),
                child: Container(
                  decoration: BoxDecoration(
//                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YoutubePlayerIFrame(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          broadcast.title,
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            broadcast.date,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 10,
                top: 10,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF0045ba),
                  child: Icon(Icons.arrow_back),
                  heroTag: broadcast.videoId + 'back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: FloatingActionButton(
                  backgroundColor: Color(0xFF0045ba),
                  child: Icon(Icons.share),
                  heroTag: broadcast.videoId + 'share',
                  onPressed: () {
                    FirebaseAnalytics().logEvent(name: 'share_broadcast',parameters: {'Broadcast':broadcast.videoId});
                    Share.shareBroadcast(broadcast.title, broadcast.videoId);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
