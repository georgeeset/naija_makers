import 'package:flutter/material.dart';
import '../widgets/profile_avatar.dart';

class CustomerProfile extends StatelessWidget {
  static const String routName='/customer_profile';
  final bool _radioValue1=true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            child:  Container(
          //padding: EdgeInsets.all(6),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              LinearProgressIndicator(),
              ProfileAvatar(null,null),

               Container(height: 20,),

               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Icon(
                          Icons.person,
                          color: Theme.of(context).accentIconTheme.color,
                        )
                      ],
                    ),
                  ),

                   Expanded(
                    flex: 2,

                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Full Name',
                            textAlign: TextAlign.start,
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                               'User Name',
                                style: Theme.of(context).textTheme.subhead,
                                textAlign: TextAlign.start,
                              ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child:  Text(
                            'Profile name will be seen by everyone who checks your profile',
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(color: Colors.black54),
                          ),
                        ),
                         Divider()
                      ],
                    ),
                    //  Text(_profile.)
                  ),

                  //  Icon(Icons.edit),
                   IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),
               Container(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Icon(
                          Icons.book,
                          color: Theme.of(context).accentIconTheme.color,
                        )
                      ],
                    ),
                  ),
                ],
              ),
               Container(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Icon(
                          Icons.email,
                          color: Theme.of(context).accentIconTheme.color,
                        )
                      ],
                    ),
                  ),

                   Expanded(
                    flex: 2,

                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Email',
                            textAlign: TextAlign.start,
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child:   Text(
                                '_profile.getEmail,',
                                style: Theme.of(context).textTheme.subhead,
                                textAlign: TextAlign.start,
                              ),
                        ),

                        Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.red,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child:  Text(
                                    'Verify',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                ),
                              ),
                            ),
                         Divider()
                      ],
                    ),
                    //  Text(_profile.)
                  ),

                  //  Icon(Icons.edit),
                   IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),
               Container(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                    //padding: EdgeInsets.only(right: 10, left: 10),
                    width: 45,
                  ),
                   Expanded(
                    flex: 2,

                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Gender',
                            textAlign: TextAlign.start,
                          ),
                        ),
                         Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                               Row(children: <Widget>[
                                 Text(
                                  'Female',
                                  style: Theme.of(context).textTheme.subhead,
                                ),
                                 Radio(
                                    value: _radioValue1,
                                    groupValue: _radioValue1,
                                    onChanged: (i) =>
                                       _radioValue1,
                                  )
                              ]),
                               Row(
                                children: <Widget>[
                                   Text(
                                    'Male',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                   Radio(
                                      value: _radioValue1,
                                      groupValue: _radioValue1,
                                      onChanged: (i) =>
                                          _radioValue1,
                                    ),
                                ],
                              ),
                            ]),
                         Divider(),
                      ],
                    ),
                    //  Text(_profile.)
                  ),
                   Container(
                    width: 45,
                  ),
                ],
              ),
               Container(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Icon(
                          Icons.info,
                          color: Theme.of(context).accentIconTheme.color,
                        )
                      ],
                    ),
                  ),

                   IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
                  )
                ],
              ),
               Container(
                height: 20,
              ),
               Container(
                height: 20,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Icon(
                          Icons.phone,
                          color: Theme.of(context).accentIconTheme.color,
                        )
                      ],
                    ),
                  ),

                   Expanded(
                    flex: 2,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Phone',
                            textAlign: TextAlign.start,
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                                '_profile.getPhoneNumber',
                                style: Theme.of(context).textTheme.subhead,
                                textAlign: TextAlign.start,
                              ),
                        ),
                         Divider(),
                      ],
                    ),
                    //  Text(_profile.)
                  ),

                  //  Icon(Icons.edit),

                   Container(
                    width: 45,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}