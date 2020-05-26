import 'package:flutter/material.dart';

class EditPen extends StatelessWidget {
  final Function clickAction;
  EditPen(this.clickAction);
  @override
  Widget build(BuildContext context) {
    return Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                      ),
                      color: Colors.white,
                      onPressed: () => clickAction(),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.black38,
                    ),
                  );
  }
}