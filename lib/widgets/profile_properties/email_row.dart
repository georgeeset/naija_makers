import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/signup_widgets/email_input_field.dart';

class EmailRow extends StatelessWidget {
  final String data;
  final Function editEmail;
  final bool isEditable;
  EmailRow({
    @required this.data,
    @required this.editEmail,
    @required this.isEditable,
  });
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    const String email='Email';
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  email,
                ),
                Container(
                  width: mediaQueryData.size.width * .80,
                  child: SelectableText(
                    data,//profile.email,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.green,
                        ),
                  ),
                ),
              ],
            ),
            isEditable
                ? IconButton(
                    icon: Icon(
                      Icons.mode_edit,
                      color: Colors.green,
                      size: 20,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              // insetAnimationDuration: Duration(milliseconds: 400),
                              backgroundColor: Colors.lightGreen[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                  height: mediaQueryData.size.height / 4,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        EmailInputField(editEmail, 'Email'),
                                        //RaisedButton(child:Text('ok'),onPressed:(){Navigator.pop(context);},)
                                      ],
                                    ),
                                  )),
                            );
                          });
                    },
                  )
                : Container(),
          ]),
    );
  }
}
