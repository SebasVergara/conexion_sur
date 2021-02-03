import 'package:flutter/material.dart';

import 'package:conexionsur/services/api.dart';
import 'package:conexionsur/models/post.dart';
import 'package:conexionsur/widgets/post_item.dart';

class PostList extends StatefulWidget {
  ScrollController scrollControllers;
  String category;
  PostList({this.scrollControllers, this.category});

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;
  ScrollController _scrollController = new ScrollController();
  int page = 0;

  bool _hasMore;
  int _pageNumber;
  bool _error;
  bool _loading;
  final int _defaultPhotosPerPageCount = 10;
  List<Post> _posts;
  final int _nextPageThreshold = 9;

  void getPosts() async {
    try {
      API.getPosts(category: widget.category, page: _pageNumber).then((_post) {
        setState(() {
          isLoading = false;
          _posts.addAll(_post);
          _hasMore = _posts.length == _defaultPhotosPerPageCount;
          _loading = false;
          _pageNumber = _pageNumber + 1;
        });
      });
    } catch (e) {
      print('ERROR');
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  void initState() {
    _hasMore = true;
    _pageNumber = 0;
    _error = false;
    _loading = true;
    _posts = [];
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return getBody();
  }

  Widget postItem(BuildContext context, int index) {
    return PostItem(_posts[index]);
  }

  Widget getBody() {
    if (_posts.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (_error) {
        return Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  getPosts();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text("Error while loading photos, tap to try agin"),
              ),
            ));
      }
    } else {
      return ListView.builder(
          itemCount: _posts.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _posts.length - _nextPageThreshold) {
              getPosts();
            }
            if (index == _posts.length) {
              if (_error) {
                return Center(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _loading = true;
                          _error = false;
                          getPosts();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text("Error while loading photos, tap to try agin"),
                      ),
                    ));
              } else {
                return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ));
              }
            }
            return postItem(context, index);
          });
    }
    return Container();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
