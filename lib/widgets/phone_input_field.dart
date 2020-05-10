import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';

class PhoneInputField extends StatefulWidget {
  //const PhoneInputField({Key key,}) : super(key: key);
  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  TextEditingController textEditingController;
  Validate validate;
  String err;
  //var _userProfile=Provider.of<ProfileProvider>(context,listen: false);

  final snackBar = SnackBar(
            content: Text('Invalid phone number'),
           // action: SnackBarAction(label: 'Undo', onPressed: () {
                // Some code to undo the change.
            //  },
            //),
          );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    validate = Validate();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.phone,
      enabled: true,
      maxLength: 11,
      textAlign: TextAlign.justify,
      textInputAction: TextInputAction.done,
      onChanged: (val) {
        setState(() {
          err = validate.validatePhone(val);
        });
      },
      onSubmitted: (val) async {
        if (err == null) {
          // call the correct function and padd val
          val=val.length<10? val.replaceFirst(RegExp(r'0'), '',0): val;
          
          await Provider.of<ProfileProvider>(context, listen: false)
              .verifyPhoneNumber('+234$val')
              //.signupAnonymously()
              .catchError((err) {
                Scaffold.of(context).showSnackBar(snackBar);
            print(err);
          });
        }
      },
      decoration: InputDecoration(
        errorText: err,
        hintText: 'Phone number',
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.primaries[10],
        ),
        prefixText: '+234',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),

        //fillColor:Theme.of(context).primaryColor,
        //filled: true
      ),
    );
  }
}
