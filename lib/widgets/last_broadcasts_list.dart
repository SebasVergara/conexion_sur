import 'package:flutter/material.dart';

import 'package:conexionsur/services/api.dart';
import 'package:conexionsur/models/broadcast.dart';

import 'last_broadcasts_card.dart';

class LastBroadCastList extends StatefulWidget {
  @override
  _LastBroadCastListState createState() => _LastBroadCastListState();
}

class _LastBroadCastListState extends State<LastBroadCastList>
    with AutomaticKeepAliveClientMixin {
  List<Broadcast> broadcasts = new List<Broadcast>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    API.getBroadcastList().then((_broadcast) {
      setState(() {
        isLoading = false;
        broadcasts.addAll(_broadcast);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
        ? Center(
              child: CircularProgressIndicator(),
        )
        : Container(
              height: 270.0,
              alignment: Alignment.topLeft,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: broadcasts.length,
                itemBuilder: (context, index) {
                  return broadcastCard(context, index);
                },
              ),
        );
  }

  Widget broadcastCard(BuildContext context, int index) {
    return LastBroadcastsCard(broadcasts[index]);
//    return LastBroadcastsCard();
  }

  @override
  bool get wantKeepAlive => true;
}
