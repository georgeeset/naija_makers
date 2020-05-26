import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';


class BusinessInfoField extends StatefulWidget {
  final Function action;
  final String labelText;
  BusinessInfoField(this.action, this.labelText);
  @override
  _BusinessInfoFieldState createState() => _BusinessInfoFieldState();

}

class _BusinessInfoFieldState extends State<BusinessInfoField> {
  String errorText;
  final Validate validate=Validate();
  @override
  Widget build(BuildContext context) {
  final profile=Provider.of<ProfileProvider>(context);
    return TextField(
            autofocus: true,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: (val){
              setState(() {
                errorText=validate.validateNote(val);
              });
            },
            onSubmitted: (value) {
              if(errorText==null){
                profile.userProfile.description =value;
                FocusScope.of(context).unfocus();
                widget.action();
               if( Navigator.canPop(context)){Navigator.pop(context);}
              }
            },
           // maxLines: 1,
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(color: Colors.black54),
              errorText: errorText,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              prefixIcon: Icon(
                Icons.note,color: Colors.green,
              ),
              //fillColor: Colors.white,
            ),
          );
  }
}