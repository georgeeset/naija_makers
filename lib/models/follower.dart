class Follower {
  final String uid;
  final int date;

  Follower(
      {
      this.uid,
      this.date,
      });

  Follower.fromMap(Map<String,dynamic>snapshot):
    uid=snapshot['uid']?? '',
    date=snapshot['date']?? '';
  
  get toMap=>{
    'date':date,
    'uid':uid,
  };
}