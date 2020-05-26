import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';

class NameInputField extends StatefulWidget {

  final Function action;
  final String labelText;
  NameInputField(this.action,this.labelText);

  @override
  _NameInputFieldState createState() => _NameInputFieldState();
}

class _NameInputFieldState extends State<NameInputField> {
  String errorText;
  Validate validate=Validate();


  @override
  Widget build(BuildContext context) {
    final profile=Provider.of<ProfileProvider>(context);
    return  TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              onChanged: (val){
                setState(() {
                  errorText=validate.validateFullName(val);
                });
              },
              onSubmitted: (value) {
                if(errorText==null&&value!=null){
                  profile.userProfile.name=value;
                  FocusScope.of(context).unfocus();
                  widget.action();
                  if(Navigator.canPop(context)){Navigator.pop(context);}
                }
              },
              //style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                errorText: errorText,
                labelText: widget.labelText,
                labelStyle: TextStyle(color: Colors.black54),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                filled: true,
                
                //fillColor: Colors.white,
              ),
           
    );
  }
}