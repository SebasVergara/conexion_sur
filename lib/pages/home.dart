import 'package:conexionsur/services/api.dart';
import 'package:flutter/material.dart';

import 'package:conexionsur/widgets/post_list.dart';
import 'package:conexionsur/widgets/last_broadcasts_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollControllers = new ScrollController();
  int value = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
            "assets/images/logoBK.png",
            height: 35.0,
          ),
      ),
      body: SafeArea(
        child: FutureBuilder(
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
}
