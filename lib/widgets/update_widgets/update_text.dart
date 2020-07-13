import 'package:flutter/material.dart';

class UpdateText extends StatefulWidget {
  final String text;
  UpdateText({this.text});

  @override
  _UpdateTextState createState() => _UpdateTextState();
}

class _UpdateTextState extends State<UpdateText> with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 400),
            reverseDuration: Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                child: child,
                axis: Axis.vertical,
                sizeFactor: animation,
                axisAlignment: 1.0,
              );
            },
            child: SelectableText(
              widget.text,
              style: TextStyle(
                fontSize: 16,
              ),
              scrollPhysics: NeverScrollableScrollPhysics(),
              key: ValueKey<bool>(isExpanded),
              maxLines: isExpanded ? null : 3,
              textAlign: TextAlign.start,
            ),
          ),
          (widget.text.length > 120 || widget.text.contains('\n'))
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      isExpanded
                          ? Text(
                              "Show Less",
                              style: TextStyle(color: Colors.green),
                            )
                          : Text("Show More",
                              style: TextStyle(color: Colors.green))
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
