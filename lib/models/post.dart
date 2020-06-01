enum MediaType { video, image }

class Post {
  final String posterName;
  final String posterUid;
  final timeStamp;
  final String mediaUrl;
  final String messageText;
  final bgColor; //expected html color symbol
  final MediaType mediaType;
  final int likesCount;

  Post({
    this.posterUid,
    this.posterName,
    this.timeStamp,
    this.mediaUrl,
    this.messageText,
    this.bgColor,
    this.mediaType,
    this.likesCount,
  });

  Post.fromMap(Map<String, dynamic> snapshot)
      : posterName = snapshot['poster_name'],
        posterUid = snapshot['poster_uid'],
        timeStamp = snapshot['time_stamp'],
        mediaUrl = snapshot['media_url'],
        messageText = snapshot['message_text'],
        bgColor = snapshot['bg_color'],
        mediaType = MediaType.values[snapshot['media_type']],
        likesCount = snapshot['likes_count'];

  get toMap => {
        'poster_name': posterName,
        'poster_uid': posterUid,
        'time_stamp': timeStamp,
        'media_url': mediaUrl,
        'essage_text': messageText,
        'bg_color': bgColor,
        'media_type': mediaType.index,
        'likes_count': likesCount,
      };
}
