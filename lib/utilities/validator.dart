
class Validate{

  String validatePassword(String val){
    if(val.isEmpty){return "Password must not be empty";}
    else{
      if(val.length<5){return "Your password is too short"; }
       return null;
    }
   
  }

  String validateEmail(String val){
    if(! RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)){
      return "Invalid email";
    }

    return null;

  }
String validateCountry(String _val){
  if(_val.isEmpty){return "Contrycode Field is empty";}
  else{
    if(_val.length<3){return " Incomplete country code";}
  }
  return null;
}
String validatePhone(String _val){
if(_val.isEmpty){return "Insert phone number";}
else{
  if(_val.length<10){return "Phone number too short";}
}
return null;
}
String validateCode(String _val){
    if(_val.isEmpty){return "Insert sms code";}
  else{
    if(_val.length<6){return "Code is too short";}
  }
  return null;
}

String validateOneWord(String _val){
  if(_val.isEmpty||_val.length<3){return "Empty Field";}
  else{
    if(!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(_val)){
      return "Alphabet and Numbers Only";
    }
    return null;
  }
}

// string with space allowedbut symbols not allowed
String validateFullName(String _val){
   //print(_val.indexOf(' ')+4);
   //print(_val.length);
  if(_val.isEmpty){return "Empty Field";}
  else{
    if(!RegExp(r"^[a-zA-Z- ]+$").hasMatch(_val)){
      return "Numbers and symbols not allowed";
    }else{

      if(_val.length<6){
        return 'Input name and surname'; 
      }else{
        if(_val.contains(' ')){
           if(_val.indexOf(' ')+4>_val.length){
            return 'Full name please';
          }else{
            return null;
          }
        }else{
            return 'add space between our names';
        }
        
      }
    }
   // return null;
  }
}
String validateString(String val){
  if(val.isEmpty){return "Oops.. it can't be empty !";}
  else{
    if(val.length<3){
      return "Too short";
    }
    return null;
  }
}

String validateNote(String val){
  if(val.isEmpty){return "Oops.. it can't be empty !";}
  else{
    if(val.length<18){
      return "Your description is too short";
    }
    return null;
  }
}

}