import 'package:flutter/material.dart';

class CloseThumbnailButton extends StatelessWidget {
  const CloseThumbnailButton({
    Key key,
    @required this.onClosed,
  }) : super(key: key);

  final Function onClosed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white30),
      child: IconButton(
        icon: Icon(Icons.close, size: 18),
        onPressed: onClosed,
      ),
    );
  }
}
