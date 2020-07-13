import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:naija_makers/data/user_type.dart';
import 'package:naija_makers/providers/posts.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:provider/provider.dart';
import '../screens/message.dart';
import '../screens/maker_profile.dart';
import '../screens/customer_profile.dart';
import '../widgets/home.dart';

class LandingPage extends StatefulWidget {
  static const String routName = '/landing_page';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Widget searchWidget;

  @override
  void initState() {
    super.initState();
    searchWidget = setSearchWidget(true);
  }

  @override
  Widget build(BuildContext context) {
    //final profile=Provider.of<ProfileProvider>(context);
    return MultiProvider(
        providers: [
          // ChangeNotifierProxyProvider<ProfileProvider, FollowersProvider>(
          //   create: (BuildContext context) {
          //   return FollowersProvider();
          // },
          // update: (_,profile, FollowersProvider previous) {
          // return previous..updateUser(profile.user);//Provider.of<ProfileProvider>(context,listen: false).user);
          // }),

          ChangeNotifierProxyProvider<ProfileProvider, PostsProvider>(
              create: (BuildContext context) {
            return PostsProvider();
          }, update: (_, changedUser, PostsProvider previous) {
            return previous
              ..updateUser(changedUser
                  .user); //Provider.of<ProfileProvider>(context,listen: false).user);
          }),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            setState(() {
              searchWidget = setSearchWidget(true);
            });
          },
          child: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Naija Makers'),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        reverseDuration: Duration(milliseconds: 400),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            child: child,
                            scale: animation,
                          );
                        },
                        child: searchWidget,
                      )
                    ],
                  ),
                  elevation: 0.5,
                  bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        child: Icon(Icons.home),
                      ),
                      Tab(
                        child: Icon(Icons.mail),
                      ),
                      Tab(
                        child: Icon(Icons.person),
                      ),
                    ],
                  ),
                ),
                // drawer: NavigatorMenu(),
                body: Stack(
                  children: <Widget>[
                    Consumer<ProfileProvider>(
                      builder: (BuildContext context, profile, _) {
                        return TabBarView(
                          children: <Widget>[
                            HomePage(),
                            MessagePage(),
                            profile.userProfile == null ||
                                    profile.userProfile.userType == null
                                ? CircularProgressIndicator()
                                : profile.userProfile.userType == UserType.maker
                                    ? MakerProfilePage(isEditable: true)
                                    : CustomerProfile(
                                        isEditable: true,
                                      ),
                          ],
                        );
                      },
                    ),
                    Consumer<ProfileProvider>(
                      builder: (BuildContext context, ProfileProvider owner,
                          Widget child) {
                        return owner.uploadTask != null
                            ? StreamBuilder<StorageTaskEvent>(
                                stream: owner.uploadTask.events,
                                builder: (_, snapshot) {
                                  print(snapshot.connectionState);
                                  //var event=snapshot?.data?.snapshot;
                                  //double progressPercent=event!= null  ? event.bytesTransferred / event.totalByteCount : 0;
                                  //if(progressPercent==100){owner.uploadevent=n}

                                  return SizedBox(
                                      height: 2,
                                      width: double.infinity,
                                      child:
                                          LinearProgressIndicator()); //value: progressPercent
                                },
                              )
                            : Container();
                      },
                    ),

                    // SizedBox(height: 3,width: double.infinity,child: LinearProgressIndicator()),
                  ],
                )),
          ),
        ));
  }

  Widget setSearchWidget(bool small) {
    return small
        ? IconButton(
            icon: Icon(
              Icons.search,
              size: 35,
              color: Colors.green,
            ),
            onPressed: () {
              setState(() {
                searchWidget = setSearchWidget(false);
              });
            })
        : Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              //autofocus: true,

              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              //onSubmitted: (vaue) => null,
              style: TextStyle(fontSize: 15),
              autofocus: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Search',

                //  InputDecoration(
                //   filled: true,

                //   hintStyle: TextStyle(fontSize: 17),
                //   hintText: 'search',
                //   suffixIcon: Icon(Icons.search),
                //   contentPadding: EdgeInsets.all(5),
                //   focusedBorder: InputBorder.none,
                //   enabledBorder: InputBorder.none,

                //fillColor: Colors.white,
              ),
            ));
  }
}
