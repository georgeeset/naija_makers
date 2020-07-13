import 'package:flutter/material.dart';
import 'package:naija_makers/providers/posts.dart';
import 'package:naija_makers/widgets/post_heart.dart';
import 'package:provider/provider.dart';
import '../dialog_dealer/warining_dialog.dart';

class UpdateActions extends StatelessWidget {
  final String postId;
  final String posterUid;
  final int likesCount;
  UpdateActions(
      {@required this.postId,
      @required this.posterUid,
      @required this.likesCount});

  final double iconSize = 25;

  @override
  Widget build(BuildContext context) {
    var post = Provider.of<PostsProvider>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.black12,
      child: Row(
        children: <Widget>[
          PostHeart(
            postId: postId,
            posterUid: posterUid,
            likesCount: likesCount,
            uid: post.userId,
            size: iconSize,
          ),

          //Container( width: 80,),
          post.userId != posterUid
              ? IconButton(
                  icon: Icon(
                    Icons.mail,
                    size: iconSize,
                  ),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: iconSize,
                  ),
                  onPressed: () async {
                    bool dialogResult = await WarningDialog.twoActionsDialog(
                      titleText: 'Delete Post',
                      bodyText: 'Are you Sure ?',
                      goodOption: 'Cancle',
                      badOption: 'Delete',
                      context: context,
                    );

                    if (dialogResult) {
                      post.deletePost(postId);
                    }
                  }),

          IconButton(
            icon: Icon(
              Icons.share,
              size: iconSize,
            ),
            onPressed: () {
              print('find out how to share post');
            },
          )

          // post.userId == posterUid
          //     ? IconButton(
          //         icon: Icon(
          //           Icons.edit,
          //           size: iconSize,
          //         ),
          //         onPressed: () {

          //         },
          //       )
          //     : Container(),
        ],
      ),
    );
  }
}
