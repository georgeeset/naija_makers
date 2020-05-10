import 'package:flutter/material.dart';

class UploadMenu extends StatelessWidget {
  final List<Map<String, dynamic>> uploadMenuItems = [
    {'title': 'Upload photo from gallery', 'icon': Icons.photo},
    {'title': 'Upload video from gallery', 'icon': Icons.video_library},
    {'title': 'Snap with camera', 'icon': Icons.camera},
    {'title': 'Record with video camera', 'icon': Icons.videocam},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Upload Option Menu',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title,
                  ),
                  color: Colors.primaries[10],
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
                          size: 40,
                          color: Colors.primaries[10],
                        ),

                        Text(
                          '${uploadMenuItems[index]['title']}',
                          style: TextStyle(fontSize: 20),
                        ),
                       
                        Padding(
                          padding: EdgeInsets.all(25),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
