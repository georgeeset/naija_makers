enum InputType {
  fullName,
  businessName,
  businessAddress,
  businessInfo,
  phone,
  phoneVerification,
  email,
  selfie,
}

class UserSignupData {
  static final List<Map<String, dynamic>> signupData = [
    {
      'action': 'Tell us your name in full',
      'label': 'Full name',
      'inputType': InputType.fullName,
    },
    
     {
      'action': 'Your Email address',
      'label': 'Email',
      'inputType': InputType.email,
    },

     {
      'action': 'Almost done, Selfie time',
      'label': 'Selfie',
      'inputType': InputType.selfie,
    }
  ];
}

class MakerSignupData{
   static final List<Map<String,Object>>signupData=[
      {
      'action': 'Tell us your name in full',
      'label': 'Full name',
      'inputType': InputType.fullName,
      },

      {
      'action': 'Give your Business a name if you don\'t have already',
      'label': 'Business name',
      'inputType': InputType.businessName,
      },

      {
      'action': 'Full Address of your business location',
      'label': 'Business address',
      'inputType': InputType.businessAddress,
      },

      {
      'action': 'Breafly tell us what you do and why you are special',
      'label': 'Business info',
      'inputType': InputType.businessInfo,
      },

      {
      'action': 'One more thing.. Selfie time ',
      'label': 'Selfie',
      'inputType': InputType.selfie,
      },


   ];
}
