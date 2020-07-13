

class Like{
  final String uid;
  final int time;

  Like({this.uid,this.time});

  Like.fromMap(Map<String,dynamic> snapshot):
  uid= snapshot['uid'],
  time= snapshot['time'];


  Map<String,dynamic> get toMap=> { 'uid': uid,'time': time};

}