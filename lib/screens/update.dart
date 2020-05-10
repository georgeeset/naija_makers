import 'package:flutter/material.dart';
import 'package:naija_makers/widgets/backgroundpicker.dart';
import '../widgets/topwidget.dart';
import '../widgets/upload_menu.dart';

class UpdatePage extends StatefulWidget {
  static const String routName = '/update_page';
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'Add New Post',
            ),
            Expanded(
              child: Container(),
            ),
            OutlineButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              child: Text(
                'POST',
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.all(5),
        width: mediaQueryData.size.width,
        height: mediaQueryData.size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,

              child: ListView(children: <Widget>[
                TopWidget(),
                Container(
                  height: 10,
                ),
                Divider(),
                SizedBox(
                  width: mediaQueryData.size.width,
                  height: mediaQueryData.size.height / 4,
                  child: Container(
                    decoration: BoxDecoration(
                        //add characteristics here after selecting background color
                        ),
                    child: TextField(
                      maxLines: null,
                      autocorrect: true,
                      textCapitalization: TextCapitalization.sentences,
                      scrollPadding: EdgeInsets.all(20),
                      style: TextStyle(fontSize: 25),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Post Description',
                        hintStyle: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                
                //Image.file(), // appears after image is loaded

              ]),
            ),
            Positioned(
              bottom: 10,
              child: BackgroundPicker(mediaQueryData.size.width,uploadButtonTapped),
            ),
          ],
        ),
      ),
    );
  }

  uploadButtonTapped(BuildContext context){
    showModalBottomSheet(
      context: context,
      elevation: 0,
      builder:(_){
        print('modal done');
        return UploadMenu();
      });
  }

}
