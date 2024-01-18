import 'package:flooter/Splash/Components/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Duration kAnimationDuration = Duration(milliseconds: 200);
  Color kPrimaryColor = Color.fromARGB(255, 96, 131, 255);

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Stream Football Match",
      "text2": "Watch professional league football matches",
      "image": "assets/1.png"
    },
    {
      "text": "Realtime Statistics",
      "text2": "Real-time football live scores and match statistics",
      "image": "assets/2.PNG"
    },
    {
      "text": "League Standings",
      "text2": "Club statistics and league standings around the world",
      "image": "assets/3.png"
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkShowSplash();
  }

  void _checkShowSplash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showSplash = prefs.getBool('showSplash') ?? true;
    // prefs.remove("showSplash"); // comment in the

    if (showSplash) {
      prefs.setBool('showSplash', false);
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: SafeArea(
        minimum: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) {
                  if (index == splashData.length - 1) {
                    // If it's the last splash screen, show a button
                    return Column(
                      children: [
                        SplashContent(
                          image: splashData[index]["image"],
                          text: splashData[index]['text'],
                          text2: splashData[index]['text2'],
                          screenHeight: screenHeight,
                        ),
                        SizedBox(height: screenHeight * 0.01), // Adjusted size
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          child: Text('Get Started'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015, // Adjusted size
                              horizontal: screenWidth * 0.1, // Adjusted size
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                      text2: splashData[index]['text2'],
                      screenHeight: screenHeight,
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1), // Adjusted size
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenHeight * 0.005, // Adjusted size
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index
            ? kPrimaryColor
            : Color.fromARGB(255, 186, 186, 186),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
