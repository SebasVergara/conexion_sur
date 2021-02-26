import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:conexionsur/models/broadcast.dart';
import 'package:conexionsur/services/api.dart';
import 'package:conexionsur/widgets/post_list.dart';
import 'package:conexionsur/widgets/last_broadcasts_list.dart';
import 'package:conexionsur/pages/news.dart';
import 'package:conexionsur/pages/broadcast.dart';
import 'package:conexionsur/models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollControllers = new ScrollController();
  int value = 1;
  Future<dynamic> authToken;

  @override
  void initState() {
    super.initState();
    authToken = API.fetchAuthToken();

    OneSignal.shared.setNotificationOpenedHandler(
            (OSNotificationOpenedResult action) async {
          Map<String, dynamic> dataNotification =
              action.notification.payload.additionalData;
          if (dataNotification.containsKey('notice')) {
            Post post;
            post = await API.getPost(slug: dataNotification['notice']);
            FirebaseAnalytics().logEvent(name: 'open_news',parameters: {'News':post.title});
            await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => News(post),
                  settings: RouteSettings(name: 'News'),
                )
            );
          } else if (dataNotification.containsKey('live')) {
            Broadcast broadcast;
            broadcast = await API.getBroadcast(id: dataNotification['live']);
            FirebaseAnalytics().logEvent(name: 'open_broadcast',parameters: {'News':broadcast.title});
            await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoBroadcast(broadcast),
                  settings: RouteSettings(name: 'VideoBroadcast'),
                )
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Image.asset(
            "assets/images/logo.png",
            height: 35.0,
          ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              "assets/images/menu.svg",
              height: 25,
              width: 34,
              color: Color(0xFF294793),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      drawer: drawerMenu(),
      body: SafeArea(
        child: FutureBuilder(
          future: API.fetchAuthToken(),
          builder: (co, snapshotData) {
            if (!snapshotData.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return FutureBuilder(
              future: API.getCategories(),
              builder: (c, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<Tab> tabs = new List<Tab>();
                List<PostList> tabsData = new List<PostList>();
                for (int i = 0; i < snapshot.data.length; i++) {
                  if ( i == 0 ) {
                    tabs.add(Tab(
                      child: Text(
                        "Todos",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ));
                    tabsData.add(PostList(category: '0'));
                  }
                  tabs.add(Tab(
                    child: Text(
                      snapshot.data[i].title,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ));
                  tabsData.add(PostList(category: snapshot.data[i].id));
//              tabsData.add(Center(child: CircularProgressIndicator(),));
                }
                return DefaultTabController(
//                length: snapshot.data.length + 1,
                  length: snapshot.data.length + 1,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          floating: true,
                          pinned: true,
                          bottom: TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            indicatorColor: Colors.pink,
                            isScrollable: true,
                            tabs: tabs,
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor, width: 3.0),
                            ),
                          ),
                          expandedHeight: 380,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.pin,
                            background: headerContent(), // This is where you build the profile part
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                        children: tabsData
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  headerContent() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                top: 15.0,
              ),
              child: Text(
                'Emisiones',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ],
        ),
        LastBroadCastList(),
      ],
    );
  }

  headerSliverApp() {
    return SliverAppBar(
      title: Image.asset(
        "assets/images/logo.png",
        height: 35.0,
      ),
      centerTitle: true,
    );
  }

  lastBroadcastTitle() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              top: 15.0,
            ),
            child: Text(
              'Emisiones',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
        ],
      ),
    );
  }
  categoriesHorizontalTabs(tabs) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Theme.of(context).backgroundColor,
      title:
      TabBar(
        labelColor: Theme.of(context).primaryColor,
        indicatorColor: Colors.pink,
        isScrollable: true,
        tabs: tabs,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
              color: Theme.of(context).primaryColor, width: 3.0),
        ),
      ),
    );
  }
  categoriesTabs(tabsData) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: tabsData,
            ),
          ),
        ],
      ),
    );
  }
  drawerMenu() {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          DrawerHeader(
            child: Container(
//                height: 100,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.asset(
                  "assets/images/logo.png",
                )),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Síguenos en:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontFamily: 'Galano',
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              _launchURL("https://www.instagram.com/conexionsuroficial/");
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.instagram),
                Text(
                  ' Instagram',
                  style: TextStyle(
                    fontFamily: 'Galano',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              _launchURL("https://www.facebook.com/ConexionSur1/");
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.facebook),
                Text(
                  ' Facebook',
                  style: TextStyle(
                    fontFamily: 'Galano',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              _launchURL("https://twitter.com/ConexionSur1");
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.twitter),
                Text(
                  ' Twitter',
                  style: TextStyle(
                    fontFamily: 'Galano',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              _launchURL("https://www.youtube.com/c/CONEXI%C3%93NSUR");
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.youtube),
                Text(
                  ' YouTube',
                  style: TextStyle(
                    fontFamily: 'Galano',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF294793),
                  child: Center(
                    child: Text(
                      'v1.0.0',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

void _launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
