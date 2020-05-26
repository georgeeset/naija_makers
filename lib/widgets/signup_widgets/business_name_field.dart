import 'package:flutter/material.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/utilities/validator.dart';
import 'package:provider/provider.dart';

class BusinessNameField extends StatefulWidget {
  final String labelText;
  final Function action;
  BusinessNameField(this.action, this.labelText);
  @override
  _BusinessNameFieldState createState() => _BusinessNameFieldState();
}

class _BusinessNameFieldState extends State<BusinessNameField> {
  String errorText;
  final Validate validate = Validate();
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    return TextField(
      autofocus: true,
      textCapitalization: TextCapitalization.none,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (val) {
        setState(() {
          errorText = validate.validateString(val);
        });
      },
      onSubmitted: (value) {
        if (errorText == null) {
          profile.userProfile.businessName = value;
          FocusScope.of(context).unfocus();
          widget.action();
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }
      },
      maxLines: null,
      decoration: InputDecoration(
        errorText: errorText,
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.black54),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        prefixIcon: Icon(
          Icons.note,
          color: Colors.green,
        ),
        //fillColor: Colors.white,
      ),
    );
  }
}
