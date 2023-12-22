import 'package:flooter/Pages/Home.dart';
import 'package:flutter/material.dart';
 

// This is the best practice
import 'splash_content.dart';

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
      "text2":
          "Real-time football live scores and match statistics",
      "image": "assets/2.PNG"
    },
    {
      "text": "League Standings",
      "text2":
          "Club statistics and league standings around the world",
      "image": "assets/3.png"
    },

  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 255, 255, 255),
        child: SafeArea(
          minimum: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Spacer(),
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]['text'],
                      text2: splashData[index]['text2'],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: (20)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 80,
                        ),
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
        ));
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
