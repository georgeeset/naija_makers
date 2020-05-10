import 'package:flutter/material.dart';

import '../widgets/presentationslidepage.dart';
import './user_type_selection.dart';
import './login.dart';

class IntroductionPage extends StatefulWidget {
  static final String routName = '/introduction_page';
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  PageController _pageController;
  bool finished = false;

  final List<Map<String, dynamic>> slideMessages = [
    {
      'title': 'Welcome to Naija Makers!',
      'note':
          'This is the platform where clients meet the makers that are good at what they do.',
    },
    {
      'title': 'Who is a maker?',
      'note':
          'I can Do X \nI can Make Y \nI can Design Z \nShow off your tallents and get the sportlight.',
    },
    {
      'title': 'Who is a client?',
      'note':
          'I need someone to do X \nI want someone to supply Y \nI am looking for a better design of Z',
    },
    {
      'title': 'Naija Makers',
      'note':
          'Regardless of your location, interested clients will find out about you and contact you. \n Grow your business with ease',
    },
  ];

  onPageListiner(int page) {
    print(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: mediaQueryData.size.height,
        width: mediaQueryData.size.width,
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: slideMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return PresentationSlidePage(slideMessages[index]['title'],
                    slideMessages[index]['note'], Colors.primaries[index + 5]);
              },
              onPageChanged: (page) {
                setState(() {
                  finished = page == slideMessages.length - 1;
                });
              },
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: _pageController.hasClients && finished
                  ? RaisedButton(
                      child: Text(
                        'Start',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                            UserTypeSelectionPage.routName);
                      },
                      elevation: 0.5,
                      shape: StadiumBorder(side: BorderSide.none),
                    )
                  : FlatButton(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    ),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: FlatButton(
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                            LoginPage.routName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
