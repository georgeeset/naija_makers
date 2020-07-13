

class Feed{
  final String postId;
  final String posterUid;
  final int time;

  Feed(this.postId,this.posterUid,this.time,);

  Feed.fromMap(Map<String,dynamic> snapshot):
    postId=snapshot['post_id'],
    posterUid=snapshot['poster_id'],
    time=snapshot['time'];
}
