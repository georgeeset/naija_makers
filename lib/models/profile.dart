import './followers.dart';
import './location.dart';
import '../assets/data/user_type.dart';


//TODO :pls add user type: to be able to defferenciate between user and maker
class Profile {
  String name;
  String businessName;
  String businessAddress;
  bool fullTime;
  String email;
  String phone;
  String profilePix;
  String businessLogo;
  List<Followers> following;
  List<Followers> followers;
  Location userLocation;
  int likes;
  String description;
  String coverPhoto;
  UserType userType;


  Profile({
    this.name,
    this.businessName,
    this.businessAddress,
    this.businessLogo,
    this.fullTime,
    this.email,
    this.phone,
    this.profilePix,
    this.followers,
    this.following,
    this.userLocation,
    this.likes,
    this.description,
    this.coverPhoto,
    this.userType,//=UserType.client,
  });


  Profile.fromMap(Map<String,dynamic>snapshot):
    name=snapshot['name']?? '',
    businessName=snapshot['business_name']?? '',
    businessAddress=snapshot['business_address']?? '',
    businessLogo=snapshot['business_logo']?? '',
    fullTime=snapshot['fullName']?? '',
    email=snapshot['email']?? '',
    phone=snapshot['phone']?? '',
    profilePix=snapshot['profille_pix']?? '',
    followers=snapshot['followers'].map((follower)=>Followers.fromMap(follower)).toList(),
    following=snapshot['following'].map((followed)=>Followers.fromMap(followed)).toList(),
    userLocation=Location.formMap(snapshot['user_location']),
    likes=snapshot['likes']??'',
    description=snapshot['description']??'',
    coverPhoto=snapshot['cover_photo'],
    userType=snapshot['user_type']?? UserType.client;
}