
import 'package:flutter/material.dart';

class EditPen extends StatelessWidget {
  final Function clickAction;
  EditPen(this.clickAction);
  @override
  Widget build(BuildContext context) {
    return Card(
          child: IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            color: Colors.white,
            onPressed: () => clickAction(),
          ),
          color: Colors.black12,
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
    );
  }
}