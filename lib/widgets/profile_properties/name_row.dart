import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/signup_widgets/name_input_field.dart';

class NameRow extends StatelessWidget {
  final String data;
  final Function editName;
  final bool isEditable;
  NameRow({
    @required this.data,
    @required this.editName,
    @required this.isEditable,
  });
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    const String name = 'Name';
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  name,
                ),
                Container(
                  width: mediaQueryData.size.width * .80,
                  child: Text(
                    data, //profile.name,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ],
            ),
            isEditable //widget.isEditable
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
                                        NameInputField(editName, name),
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
