
enum MessageType{
  textMessage,
  image,
  video,
  location,
}

enum MessageStatus{
  sent,
  delivered,
  seen,
  deleted,
}

class ChatPartyInfo{
  final String photoUrl;
  final String fullName;

  ChatPartyInfo({this.photoUrl,this.fullName});

  ChatPartyInfo.fromMap(Map<String,String> snapshot):
    fullName=snapshot['full_name'],
    photoUrl=snapshot['photo_url'];

}
class Message{
  final String from;
  final String message;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final String captionText;
  final timeSent;

  Message({this.from,this.messageType,this.messageStatus ,this.message,this.timeSent,this.captionText});

  Message.fromMap(Map<String,dynamic> snapshot):
  from=snapshot['from_uid']?? '',
  message=snapshot['message']?? '',
  messageType=snapshot['message_type']?? null,
  captionText=snapshot['caption_text']?? '',
  timeSent=snapshot['time_sent']?? null,
  messageStatus=snapshot['message_status']?? null;


}

class Conversation{
  
  final timeStamp; //converted as =timeStamp.fromMillisecondsSinceEpoch
  final List<String>chatParties;
  final Message lastMessage;
  final int unredCount;

  Conversation({this.timeStamp,this.chatParties,this.lastMessage,this.unredCount});

  Conversation.fromMap(Map<String,dynamic>snapshot):
  chatParties= snapshot['parties']??[],
  lastMessage= snapshot['last_message']??null,
  timeStamp=snapshot['time-stamp']??null,//time of last conversation
  unredCount=snapshot['unred_count']??0;
}