import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:naija_makers/data/user_type.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/repository/profile_info_service.dart';
import 'package:naija_makers/screens/profile.dart';
import 'package:naija_makers/utilities/time_mixer.dart';
import 'package:naija_makers/widgets/online_avatar.dart';

import '../constants.dart' as Constants;

class PosterInfo extends StatefulWidget {
  final String posterId;
  final int timeStamp;
  final String postId;
  PosterInfo({@required this.posterId, @required this.timeStamp,@required this.postId});

  @override
  _PosterInfoState createState() => _PosterInfoState();
}

class _PosterInfoState extends State<PosterInfo> {
  final ProfileInfoService profileInfoService = ProfileInfoService();
  Future<Profile> posterProfile;
  Future<int> followersCount;
  final TimeMixer timeMixer= new TimeMixer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posterProfile = profileInfoService.userInfo(widget.posterId);
    followersCount = profileInfoService.followersCount(widget.posterId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: FutureBuilder<Profile>(
        future: posterProfile,
        builder: (context, userData) {
          //print(userData.connectionState);
          return userData.connectionState == ConnectionState.done
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    OnlineAvatar(
                      editClicked: null,
                      editable: false,
                      radius: 40.0,
                      ringColor: Colors.green,
                      fullImageLink: userData.data.profilePix,
                      imageLink: userData.data.profilePixThumb,
                      heroTag: widget.postId,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SelectableText(
                            userData.data.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            maxLines: null,
                            onTap: () {
                              userData.data.userType == UserType.maker
                                  ? Navigator.pushNamed(
                                      context, ProfilePage.routName,
                                      arguments: userData.data)
                                  : Navigator.pushNamed(
                                      context, ProfilePage.routName,
                                      arguments: userData.data);
                            },
                          ), // add onTap to open profile Page

                          Text('${userData.data.businessName?? Constants.seriousClient}', softWrap: true,),

                          FutureBuilder<int>(
                            future: followersCount,
                            builder: (context, count) {
                              return count.connectionState == ConnectionState.done
                                  ? Text('${count.data?? 0} ${Constants.followers}')
                                  : Container();
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '${timeMixer.makeDayAtTime(DateTime.fromMillisecondsSinceEpoch(widget.timeStamp))}',
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Container(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                              width: 100,
                              color: Colors.green,
                            ),
                            Container(
                              height: 10,
                              width: 50,
                              color: Colors.green,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 100,
                                ),
                                Container(
                                  height: 10,
                                  width: 50,
                                  color: Colors.green,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
