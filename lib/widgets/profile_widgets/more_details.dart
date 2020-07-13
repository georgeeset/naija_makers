import 'package:flutter/material.dart';
import 'package:naija_makers/models/post.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/providers/posts.dart';
import 'package:naija_makers/widgets/update_widgets/update_template.dart';
import 'package:provider/provider.dart';

/// this will carry informations like recent posts and makers or customers interests
///
///
///

class MoreDetails extends StatelessWidget {
  final bool isEditable;
  final bool isMaker;
  final Profile profile;
  const MoreDetails({this.isEditable, this.isMaker, this.profile});

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      children: [
        ExpansionPanel(
          headerBuilder: (context, isExpanded) {
            return Container(
              child: Text(
                'Recent Posts',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            );
          },
          body: Consumer<PostsProvider>(
            builder: (context, posts, child) {
              // get all the posts by one person
              return FutureBuilder<List<Post>>(
                future: posts.getAllUserPosts(profile.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return snapshot.hasData == false
                        ? Text(
                            'you are not following anybody',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.white),
                          )
                        : ListView.builder(
                            itemCount: posts.posts.length,
                            itemBuilder: (context, index) {
                              return UpdateTemplate(data: posts.posts[index]);
                            });
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );

              //     return Center(child: Text(posts.testPoste ));
            },
          ),
        )
      ],
    );
  }
}
