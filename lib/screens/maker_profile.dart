import 'package:flutter/material.dart';

class MakerProfilePage extends StatelessWidget {
  static const routName = '/maker_profile';
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    const double avatarRadius = 100;
    // return  CustomScrollView(
    //     slivers: <Widget>[
    //       SliverAppBar(
    //         expandedHeight: 300,
    //         pinned: true,
    //         flexibleSpace: FlexibleSpaceBar(
    //           title: Text('person name'),
    //           background: Container(height: 250,width: double.infinity, color: Colors.red,),
    //         ),

    //       ),
    //       SliverList(
    //         delegate: SliverChildListDelegate(
    //           [
    //            SizedBox(height: 10,),
    //           ]
    //         ),
    //       ),
    //     ],
    //   );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.green,
                    ),
                    //child: Image.network(),
                  ),
                  Positioned(
                    bottom: 10,
                    left: (mediaQueryData.size.width / 2) - avatarRadius,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: ClipOval(
                            child: Container(
                              height: 190.0,
                              width: 190.0,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            myContainer(),
            Row(children: <Widget>[
              Text(
                'Name:',
              ),
              Text(
                ' User name in full',
                style: Theme.of(context).textTheme.subhead,
              ),
            ]),
            myContainer(),
            Row(
              children: <Widget>[
                Text(
                  'Business name:',
                ),
                Text(
                  'Business Name in full',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),

            myContainer(),

              Row(
              children: <Widget>[
                Text(
                  'Address:',
                ),
                Text(
                  ' Business/Home address',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
              myContainer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                    color: Colors.green),
                  child: Center(child: Text('Logo',style: TextStyle(color: Colors.white,),)),
                ),
                Container(width: 10,),
                Expanded(
                                child: Text(
                    'Job description',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ],
            ),
            myContainer(),
            Text('Recent Post',style: Theme.of(context).textTheme.title, textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
  Widget myContainer(){
    return  Container(height: 20);
  }
}
