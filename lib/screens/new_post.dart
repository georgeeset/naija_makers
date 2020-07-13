import 'package:flutter/material.dart';
import 'package:naija_makers/data/media_type.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/providers/new_post.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/widgets/dialog_dealer/warining_dialog.dart';
import 'package:naija_makers/widgets/post_widgets/Image_manager.dart';
import 'package:naija_makers/widgets/post_widgets/video_preview.dart';
import '../widgets/post_widgets/backgroundpicker.dart';
import 'package:naija_makers/widgets/online_avatar.dart';
import 'package:naija_makers/widgets/post_widgets/post_input.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatelessWidget {
  static const String routName = '/new_post_page';
  final Profile profile;
  const NewPostPage({@required this.profile});

  @override
  Widget build(BuildContext context) {
    print('new Message build');
    // final postObserver = Provider.of<NewPostProvider>(context, listen: false);

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    FocusScopeNode currentFocus = FocusScope.of(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProxyProvider<ProfileProvider, NewPostProvider>(
            create: (BuildContext context) {
          return NewPostProvider();
        }, update: (_, changedUser, NewPostProvider previous) {
          return previous..updateUser(changedUser.user);
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              const Text(
                'Add New Post',
              ),
              Expanded(
                child: Container(),
              ),
              Consumer<NewPostProvider>(builder: (context, newPost, child) {
                return OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'POST',
                    ),
                    onPressed: () {
                      // if (!currentFocus.hasPrimaryFocus) {
                      //   currentFocus.unfocus();
                      // }
                      // if (newPost.message == null) return;
                      newPost
                          .sendSequence()
                          .then((_) => Navigator.pop(context))
                          .catchError((err) =>
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(err.toString(),
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.purple,
                              )));
                    } //enable this if user has typed something postable
                    );
              }),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Consumer<NewPostProvider>(
          builder: (context, postObserver, child) {
            return WillPopScope(
              onWillPop: () async {
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }

                if (postObserver.wasUserDoingNothing()) {
                  return true;
                } else {
                  bool choice = await _attemptExit(context);
                  if (choice) {
                    // if user say true, then delete all uploads else dont delete anything
                    postObserver.eraseUploadsBeforeYouDie();
                    // print('deletingDaaa');
                    return Future.delayed(Duration(seconds: 1), () => true);
                  }
                  return false;
                } // go ahead to delete data
              },
              child: child,
            );
          },
          child: Container(
            padding: EdgeInsets.all(5),
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: mediaQueryData.size.width,
                  height: mediaQueryData.size.height,
                  child: ListView(children: <Widget>[
                    OnlineAvatar(
                      radius: 40,
                      imageLink: profile.profilePix,
                      enableEnlarge: false,
                      heroTag: profile.profilePix,
                    ),
                    Container(
                      height: 10,
                    ),
                    //Divider(),

                    Consumer<NewPostProvider>(
                      builder: (context, post, child) {
                        return AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            width: mediaQueryData.size.width,
                            curve: Curves.easeInOut,
                            height: post.noBgColor ? 130 : 250,
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                              //add characteristics here after selecting background color
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                style: BorderStyle.solid,
                              ),
                              color: post.noBgColor
                                  ? Colors.white
                                  : Colors.primaries[
                                      post.bgColor], //.withOpacity(0.4),
                              image: post.noBgColor
                                  ? null
                                  : DecorationImage(
                                      colorFilter: new ColorFilter.mode(
                                          Colors.black.withOpacity(0.5),
                                          BlendMode.dstATop),
                                      image: const AssetImage(
                                          'assets/images/bloom.png'),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: Center(
                                // alignment: post.noBgColor
                                //     ? Alignment.topLeft
                                //     : Alignment.center,
                                child: child));
                      },
                      child: PostInput(),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Consumer<NewPostProvider>(
                        builder: (context, post, child) {
                          return post.mediaType == MediaType.video
                              ? Column(
                                  children: <Widget>[
                                    VideoPreview(
                                      link: post.mediaUrl,
                                      onClosed: () => post.removeVideo(),
                                      videoFile: post.videoFile,
                                    ),
                                  ],
                                )
                              : post.mediaType == MediaType.image &&
                                      post.multiImage.isNotEmpty
                                  ? ImageManager()
                                  : Container();
                        },
                      ),
                    ),
                  ]),
                ),
                Positioned(
                  bottom: 5,
                  child: BackgroundPicker(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _attemptExit(BuildContext context) async {
    print('back button pressed');
    bool dialogResult = await WarningDialog.twoActionsDialog(
          titleText: 'Exit Post Editor',
          bodyText: 'Your message will be deleted\nAre you Sure ?',
          goodOption: 'Stay',
          badOption: 'Discard',
          context: context,
        ) ??
        false; // becomes false if dialog is dismised

    if (dialogResult) {
      print('bad option selected');
      return true;
    } else {
      print('good Option selected');
      return false;
    }

    //save data here.
  }

  // void uploadButtonTapped(BuildContext context)async{
  //  int choice=await showModalBottomSheet(
  //     context: context,
  //     elevation: 0,
  //     builder:(_){
  //       //print('modal done');
  //       return UploadMenu();
  //     });

  //     print(choice);
  // }

  // void changeColor(int newColor){
  //   if(bgColor!=newColor){
  //      setState(() {
  //        bgColor=newColor;
  //      });
  //   }
  // }

}
