enum InputType {
  text,
  textMultiLine,
  phone,
  phoneVerification,
  email,
  selfie,
}

class UserSignupData {
  static final List<Map<String, dynamic>> signupData = [
    {
      'action': 'Tell us your name in full',
      'label': 'Full Name',
      'inputType': InputType.text,
    },
    
     {
      'action': 'Your Email address',
      'label': 'email',
      'inputType': InputType.email,
    },

    // {
    //   'action': 'Mobile Number',
    //   'label': 'Phone',
    //   'inputType': InputType.phone,
    // },

    // {
    //   'action': 'Phone code have been sent',
    //   'label': 'Verify',
    //   'inputType': InputType.phoneVerification,
    // },

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
      'label': 'Full Name',
      'inputType': InputType.text,
      },

      {
      'action': 'Give your Business a name if you don\'t have already',
      'label': 'Business Name',
      'inputType': InputType.text,
      },

      {
      'action': 'Full Address of your business location',
      'label': 'Business Address',
      'inputType': InputType.text,
      },

      {
      'action': 'Breafly tell us what you do and why you are special',
      'label': 'Business info',
      'inputType': InputType.textMultiLine,
      },

      {
      'action': 'One more thing.. Selfie time ',
      'label': 'Selfie',
      'inputType': InputType.selfie,
      },


   ];
}
