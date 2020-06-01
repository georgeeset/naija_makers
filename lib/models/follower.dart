class Follower {
  final name;
  final uid;
  final businessName;
  final businessLogo;
  final profilePix;

  Follower(
      {this.name,
      this.uid,
      this.businessName,
      this.businessLogo,
      this.profilePix});

  Follower.fromMap(Map<String,dynamic>snapshot):
    name=snapshot['name']?? '',
    uid=snapshot['uid']?? '',
    businessName=snapshot['business_name'],
    businessLogo=snapshot['business_logo'],
    profilePix=snapshot['profile_pix'];
  
  get toMap=>{
    'name':name,
    'uid':uid,
    'business_name':businessName,
    'business_logo':businessLogo,
    'profile_pix':profilePix,
  };
}