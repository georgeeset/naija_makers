
import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';

class PhoneVerificationField extends StatefulWidget {
  @override
  _PhoneVerificationFieldState createState() => _PhoneVerificationFieldState();
}

class _PhoneVerificationFieldState extends State<PhoneVerificationField> {
  final Validate validate=Validate();
  TextEditingController textEditingController;
  String err;
   final snackBar = SnackBar(
            content: Text('Invalid Verification code'),
           // action: SnackBarAction(label: 'Undo', onPressed: () {
                // Some code to undo the change.
            //  },
            //),
          );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController= TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
      enabled: true,
      maxLength: 6,
      textAlign: TextAlign.justify,
      textInputAction: TextInputAction.done,
      onChanged:(val){
        setState(() {
          err=validate.validateCode(val);
        });
      },
      onSubmitted: (val) async{
        if(validate.validateCode(val)==null){
          await Provider.of<ProfileProvider>(context, listen: false)
              .signInWithPhoneNumber(val)
              //.then((val)=>print(val))
              .catchError((err) {
            //print(err);
             Scaffold.of(context).showSnackBar(snackBar);// notify user of invalid code
          });
        }
      },
      decoration: InputDecoration(
          errorText: err,
          hintText:'SMS Code',
          prefixIcon: Icon(Icons.phone,color: Colors.primaries[10],),
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