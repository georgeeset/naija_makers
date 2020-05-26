import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';

class EmailInputField extends StatefulWidget {
  final Function action;
  final String labelText;
  EmailInputField(this.action,this.labelText);
  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  String errorText;
  final Validate validate=Validate();

  @override
  Widget build(BuildContext context) {
    final profile=Provider.of<ProfileProvider>(context);
    return  TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateEmail(val);
              });
            },
            onSubmitted: (value){
              if(errorText==null){
                profile.userProfile.email=value;
                FocusScope.of(context).unfocus();
                widget.action();
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              }
            },
            decoration: InputDecoration(
              labelText: widget.labelText,
              errorText: errorText,
              labelStyle: TextStyle(color: Colors.black54),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              prefixIcon: Icon(
                Icons.email,
              ),
              //fillColor: Colors.white,
            ),
          );
  }
}