import 'package:flutter/material.dart';
import 'package:naija_makers/data/user_type.dart';
import 'package:naija_makers/providers/posts.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/screens/new_post.dart';
import 'package:provider/provider.dart';
import 'update_widgets/update_template.dart';
import './behavior/scroll_behavior.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<PostsProvider>(context, listen: false).callPosts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('scroll to end');

        if (Provider.of<PostsProvider>(context, listen: false).listExhausted) {
          return;
        }
        Provider.of<PostsProvider>(context, listen: false).callPosts();
        Scaffold.of(context).showSnackBar(SnackBar(
          content: LinearProgressIndicator(),
          backgroundColor: Colors.black26,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Home tab build');
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    //var profile=Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey,
      // body: ListView(
      //   children: <Widget>[
      //      UpdateTemplate(),
      //   ],
      // ),

      body: Consumer<PostsProvider>(
        builder: (BuildContext context, PostsProvider posts, Widget child) {
          // print('list length ${posts.posts.length}');
          // List<Post> _postList= List<Post>();
          // _postList= posts.posts;
          //return _postList.isEmpty
          return posts.posts.isEmpty
              ? Container(
                  width: mediaQueryData.size.width,
                  height: mediaQueryData.size.height,
                  child: Center(
                      child: posts.isalone
                          ? Text(
                              'you are not following anybody',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.white),
                            )
                          : CircularProgressIndicator()))
              : RefreshIndicator(
                  onRefresh: () => posts.callRefresh(),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: posts.posts.length,
                      itemBuilder: (context, index) {
                        //print(_postList[index].messageText);
                        //return Text(posts.posts[index].posterUid);
                        return UpdateTemplate(data: posts.posts[index]);
                      },
                    ),
                  ),
                );
          //     return Center(child: Text(posts.testPoste ));
        },
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      floatingActionButton: Consumer<ProfileProvider>(
        //tooltip: 'Increment',

        builder: (BuildContext context, ProfileProvider profile, Widget child) {
          return profile.userProfile.userType == UserType.maker
              ? FloatingActionButton(
                  elevation: 0,
                  mini: true,
                  onPressed: () async {
                    // Navigator.of(context).pushNamed(UpdatePage.routName,arguments: profile.userProfile);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NewPostPage(profile: profile.userProfile),
                    ));
                    //await Provider.of<ProfileProvider>(context, listen: false).signOut();
                  },
                  child: Icon(Icons.add),
                )
              : Container();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
