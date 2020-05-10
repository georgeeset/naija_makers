import 'package:flutter/material.dart';
import '../screens/message.dart';
import '../screens/maker_profile.dart';
import '../screens/customer_profile.dart';
import '../widgets/home.dart';

class LandingPage extends StatefulWidget {
  static const String routName = '/landing_page';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

 Widget searchWidget;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchWidget=setSearchWidget(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         FocusScopeNode currentFocus=FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
         setState(() {
            searchWidget=setSearchWidget(true);
          });
      },
          child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Naija Makers'),
                 AnimatedSwitcher(duration: Duration(milliseconds:400),
                 switchInCurve: Curves.easeIn,
                 switchOutCurve: Curves.easeOut,
                 transitionBuilder: (Widget child, Animation<double>animation){
                   return ScaleTransition(child: child, scale: animation,);
                 },
                  child: searchWidget,
                 )

              ],
            ),
            elevation: 0.5,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  child: Icon(Icons.home),
                ),
                Tab(
                  child: Icon(Icons.mail),
                ),
                Tab(
                  child: Icon(Icons.person),
                ),
              ],
            ),
          ),
          // drawer: NavigatorMenu(),
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              MessagePage(),
              //CustomerProfile(),
              MakerProfilePage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget setSearchWidget(bool small){
    return
    small
    ?IconButton(
    icon: Icon(Icons.search,size:35, color: Colors.green,),

    onPressed: () {
      setState(() {
        searchWidget= setSearchWidget(false);
      });
    }
    )
    : Container(
    width: 200,
    padding: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(25),
    ),
    child:TextField(
      //autofocus: true,
      
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      //onSubmitted: (vaue) => null,
      style: TextStyle(fontSize: 15 ),
      autofocus: true,
       decoration: 
        InputDecoration.collapsed(
          hintText: 'Search',

      //  InputDecoration(
      //   filled: true,
        
      //   hintStyle: TextStyle(fontSize: 17),
      //   hintText: 'search',
      //   suffixIcon: Icon(Icons.search),
      //   contentPadding: EdgeInsets.all(5),
      //   focusedBorder: InputBorder.none,
      //   enabledBorder: InputBorder.none,

        //fillColor: Colors.white,
      ),
  ))
    ;
  }
}
