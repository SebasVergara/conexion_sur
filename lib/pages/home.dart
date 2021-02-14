import 'package:conexionsur/services/api.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:conexionsur/widgets/post_list.dart';
import 'package:conexionsur/widgets/last_broadcasts_list.dart';
import 'package:conexionsur/pages/news.dart';
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
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => News(post)));
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          title: Image.asset(
            "assets/images/logoBK.png",
            height: 35.0,
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
//          SizedBox(
//            height: 30,
//          ),
//          DrawerHeader(
//            child: Container(
//                height: 142,
//                width: MediaQuery.of(context).size.width,
//                child: Image.asset(
//                  "assets/images/ten_news.png",
//                )),
//            decoration: BoxDecoration(
//              color: Colors.transparent,
//            ),
//          ),
//          SizedBox(
//            height: 20,
//          ),
//          GestureDetector(
//            onTap: () {
//              setState(() {
//                currentIndex = 3;
//              });
//              Navigator.of(context).pop();
//            },
//            child: Text(
//              'Profile',
//              style: TextStyle(
//                fontFamily: 'Avenir',
//                fontSize: 24,
//                fontWeight: FontWeight.w700,
//              ),
//              textAlign: TextAlign.center,
//            ),
//          ),
          SizedBox(
            height: 45,
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            'About',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 45,
          ),
          Text(
            'Log Out',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 45,
          ),
          Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      'v1.0.1',
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
