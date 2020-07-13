import 'package:flutter/material.dart';
import 'package:naija_makers/repository/likes_manager.dart';

class PostHeart extends StatefulWidget {
  final String posterUid;
  final String postId;
  final int likesCount;
  final String uid;
  final double size;
  PostHeart(
      {@required this.postId,
      @required this.posterUid,
      @required this.likesCount,
      @required this.uid,
      @required this.size});

  @override
  _PostHeartState createState() => _PostHeartState();
}

class _PostHeartState extends State<PostHeart> {
  LikesManager _likesManager;
  int likesCount;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    likesCount = widget.likesCount ?? 0;
    _likesManager = LikesManager();
    _likesManager.likeStatus(widget.posterUid, widget.postId, widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    print('Post heart rebuild');

    return Container(
      child: Row(
        children: <Widget>[
          FutureBuilder<bool>(
            future: _likesManager.likeStatus(
                widget.posterUid, widget.postId, widget.uid),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                isLiked = isLiked;
              } else {
                isLiked = snapshot.connectionState == ConnectionState.done
                    ? snapshot.data
                    : isLiked;
              }

              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  reverseDuration: Duration(milliseconds: 500),
                  switchInCurve: Curves.elasticInOut,
                  switchOutCurve: Curves.elasticInOut,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      child: child,
                      scale: animation,
                    );
                  },
                  child: IconButton(
                      icon: isLiked
                          ? Icon(Icons.favorite, size: widget.size)
                          : Icon(Icons.favorite_border, size: widget.size),
                      key: ValueKey<bool>(isLiked),
                      onPressed: () {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          if (isLiked) {
                            _likesManager.unLikePost(
                                widget.posterUid, widget.postId, widget.uid);
                            likesCount = likesCount == 0 ? 0 : likesCount - 1;
                          } else {
                            _likesManager.likePost(
                                widget.posterUid, widget.postId, widget.uid);
                            likesCount += 1;
                          }
                          isLiked = !isLiked;
                          setState(() {});
                        }
                      }));
            },
            initialData: false,
          ),
          Container(
              width: 40,
              height: 20,
              child: FittedBox(
                  fit: BoxFit.contain,
                  alignment: Alignment.topLeft,
                  child: Text('$likesCount'))),
        ],
      ),
    );
  }
}
