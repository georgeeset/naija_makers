import 'package:flutter/material.dart';

class PositionedBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      child: Container(
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.black12),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          )),
    );
  }
}
