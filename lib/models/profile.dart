import './followers.dart';
import './location.dart';
import '../data/user_type.dart';


//TODO :pls add user type: to be able to defferenciate between user and maker
class Profile {
  String name;
  String businessName;
  String businessAddress;
  bool fullTime;
  String email;
  //String phone;
  String profilePix;
  String businessLogo;
  //Location userLocation;
  int likes;
  String description;
  String coverPhoto;
  UserType userType;
  String profilePixThumb;

  Profile({
    this.name,
    this.businessName,
    this.businessAddress,
    this.businessLogo,
    this.fullTime,
    this.email,
    //this.phone,
    this.profilePix,
    //this.userLocation,
    this.likes,
    this.description,
    this.coverPhoto,
    this.userType=UserType.client,
    this.profilePixThumb,
  });


  Profile.fromMap(Map<String,dynamic>snapshot):
    name=snapshot['name']?? '',
    businessName=snapshot['business_name']?? '',
    businessAddress=snapshot['business_address']?? '',
    businessLogo=snapshot['business_logo']?? '',
    fullTime=snapshot['fullTime']?? false,
    email=snapshot['email']?? '',
    //phone=snapshot['phone']?? '',
    profilePix=snapshot['profile_pix']?? '',
    //followers=snapshot['followers']?.map((follower)=>Followers.fromMap(follower))?.toList(),
    //following=snapshot['following']?.map((followed)=>Followers.fromMap(followed))?.toList(),
    //userLocation= Location.formMap(snapshot['user_location']),
    likes=snapshot['likes']?? 0,
    description=snapshot['description']??'',
    coverPhoto=snapshot['cover_photo'],
    userType=UserType.values[snapshot['user_type']],
    profilePixThumb=snapshot['profile_pix_thumb'] ;

    Map<String,dynamic> get toMap=>{
      'name':name,
      'business_name':businessName,
      'business_address':businessAddress,
      'business_logo':businessLogo,
      'fullTime':fullTime,
      'email':email,
      //'phone':phone,
      'profile_pix':profilePix,
      //'followers':followers,
      //'following':following,
      //'user_location':userLocation, 
      'likes':likes,
      'description':description,
      'cover_photo':coverPhoto,
      'user_type':userType.index,
      'profile_pix_thumb':profilePixThumb
    };
}