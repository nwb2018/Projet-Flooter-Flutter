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
  Color kPrimaryColor = Color.fromARGB(200,0,249,93);

  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Suivez votre équipe de sport amateur",
      "text2": "Suivez votre équipe de sport amateur",
      "image": "assets/GARK-LOGO icon + text.png"
    },
    {
      "text": "Suivez vos matchs & entrainements",
      "text2":
          "Suivez vos matchs & entrainements",
      "image": "assets/cal.png"
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
                         SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 250, // <-- Your width
                          child: Container(
                            // padding: EdgeInsets.only(top: 30),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (c) => Home()));
                              },

                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(200,0,249,93),
                              ),

                              child: Text(
                                "Créer un compte",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(199, 255, 255, 255),
                                  fontWeight: FontWeight.w400,
                                ),
                              ), //label text,
                            ),
                          ),
                        ),
                          SizedBox(
                          height: 10,
                        ),
                        new GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (c) => Home()));
                          },
                          child: new Text(
                            "Connexion",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(200,0,249,93),
                              fontWeight: FontWeight.w600,
                            ),
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
