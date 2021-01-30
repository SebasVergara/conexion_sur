import 'package:flutter/material.dart';

import 'package:conexionsur/services/api.dart';
import 'package:conexionsur/models/post.dart';
import 'package:conexionsur/widgets/post_item.dart';

class PostList extends StatefulWidget {
  ScrollController scrollControllers;
  PostList({this.scrollControllers});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList>
    with AutomaticKeepAliveClientMixin {
  List<Post> posts = new List<Post>();
  bool isLoading = false;
  ScrollController _scrollController = new ScrollController();
  int page = 0;

  void getPosts() {
    if (!isLoading) {
      setState(() {
        page++;
        isLoading = true;
      });

      API.getPosts(category: 0, page: page).then((_post) {
        setState(() {
          print(_post);
          isLoading = false;
          posts.addAll(_post);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPosts();
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent - 0) {
        getPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
      physics: new AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return postItem(context, index);
              },
              childCount: posts.length,
            )
        ),
      ],
    );
  }

  Widget postItem(BuildContext context, int index) {
    return PostItem(posts[index]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
