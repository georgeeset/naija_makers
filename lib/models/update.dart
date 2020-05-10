enum MediaType{
  video,
  image
}

class Update{
  final String posterName;
  final String posterUid;
  final int followers;
  final timeStamp;
  final String photoUrl;
  final String messageText;
  final bgColor; //expected html color symbol
  final MediaType mediaType;
  final int likesCount;

  Update({this.posterUid,this.followers,this.posterName,this.timeStamp,this.photoUrl,this.messageText,this.bgColor,this.mediaType,this.likesCount});

  Update.fromMap(Map<String,dynamic> snapshot):
  posterName=snapshot['poster_name'],
  posterUid=snapshot['poster_uid'],
  followers=snapshot['followers_count'],
  timeStamp=snapshot['time_stamp'],
  photoUrl=snapshot['photo_url'],
  messageText=snapshot['message_text'],
  bgColor=snapshot['bg_color'],
  mediaType=snapshot['media_type'],
  likesCount=snapshot['like_count'];
}