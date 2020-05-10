import 'package:flutter/material.dart';

class UpdateActions extends StatefulWidget {
  const UpdateActions({
    Key key,
  }) : super(key: key);

  @override
  _UpdateActionsState createState() => _UpdateActionsState();
}

class _UpdateActionsState extends State<UpdateActions> {
  final Widget like = Icon(Icons.favorite_border, size: 30);
  final Widget liked = Icon(Icons.favorite, size: 30);
  final double iconSize=30;
  Widget likeStatus;
  bool isLiked = false; //provide this

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    likeStatus=like;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedSwitcher(
                duration: Duration(milliseconds: 400),
                switchInCurve: Curves.easeInOutExpo,
                switchOutCurve:Curves.elasticInOut,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition (
                    child: child,
                    scale: animation,
                  );
                },
                child: IconButton(
                    icon: likeStatus,key: ValueKey<bool>(isLiked),
                    onPressed: () {
                       isLiked=!isLiked;
                      setState(() {
                        likeStatus = isLiked ? liked : like;
                      });
                    }),
              ),
               Text('32'),
            ],
          ),

          //Container( width: 80,),
          IconButton(
            icon: Icon(
              Icons.mail,
              size: iconSize,
            ),
            onPressed: () {},
          ),

          IconButton(
            icon: Icon(
              Icons.edit,
              size:iconSize,
            ),
            onPressed: () {},
          ),

           IconButton(
            icon: Icon(
              Icons.delete,
              size: iconSize,
            ),
            onPressed: () {},
          ),
          
        ],
      ),
    );
  }
}
