import 'package:flutter/material.dart';

class UploadMenu extends StatelessWidget {
  final List<Map<String, dynamic>> uploadMenuItems;
  UploadMenu({this.uploadMenuItems});

  @override
  Widget build(BuildContext context) {
    //final post= Provider.of<NewPostProvider>(context, listen: false);
    //Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20),
                child: Text('Upload Option Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                color: Theme.of(context).accentColor,
              ),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: uploadMenuItems.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                splashColor: Colors.primaries[10],
                child: Container(
                  padding: EdgeInsets.only(left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        uploadMenuItems[index]['icon'],
                        size: 30,
                        color: Colors.primaries[10],
                      ),
                      Flexible(
                        child: Text(
                          '${uploadMenuItems[index]['title']}',
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(index);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
