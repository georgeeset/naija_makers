import 'package:flutter/material.dart';
import 'package:naija_makers/models/profile.dart';
import 'package:naija_makers/providers/user.dart';
import 'package:naija_makers/screens/update.dart';
import 'package:provider/provider.dart';
import '../widgets/update_template.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //var profile=Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ListView(
        children: <Widget>[
           UpdateTemplate(),
        ],
      ),
           //floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
   
     floatingActionButton: FloatingActionButton(
          elevation: 0,
          mini: true,
          onPressed:() async {
            //Navigator.of(context).pushNamed(UpdatePage.routName);
            await Provider.of<ProfileProvider>(context, listen:false).signOut();
          },
          //tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}