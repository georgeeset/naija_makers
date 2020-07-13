import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/media_type.dart';

class Post {
  String posterUid;
  int timeStamp;
  String mediaUrl; //  for video only
  String messageText;
  int bgColor; //expected color in integer format
  bool noBgColor = true; //no background color at first
  MediaType mediaType;
  int likesCount;
  String postId;
  double fontSize;
  List<String> multiImage = []; //4 slots for images only

  Post({
    this.posterUid,
    this.timeStamp,
    this.mediaUrl,
    this.messageText,
    this.bgColor,
    this.noBgColor = true,
    this.mediaType = MediaType.text,
    this.likesCount,
    this.postId,
    this.fontSize,
    this.multiImage,
  });

  Post.fromMap(DocumentSnapshot snapshot)
      : postId = snapshot.documentID,
        posterUid = snapshot.data['poster_uid'],
        timeStamp = snapshot.data['time_stamp'],
        mediaUrl = snapshot.data['media_url'],
        messageText = snapshot.data['message_text'],
        bgColor = snapshot.data['bg_color'],
        noBgColor = snapshot.data['no_bg_color'],
        mediaType = MediaType.values[snapshot.data['media_type']],
        likesCount = snapshot.data['likes_count'],
        fontSize = snapshot.data['font_size'],
        multiImage = snapshot.data['multiImages'].cast<String>();

  get toMap => {
        'poster_uid': posterUid,
        'time_stamp': timeStamp,
        'media_url': mediaUrl,
        'message_text': messageText,
        'bg_color': bgColor,
        'no_bg_color': noBgColor,
        'media_type': mediaType.index,
        'likes_count': likesCount,
        'font_size': fontSize,
        'multiImages': multiImage,
      };
}
