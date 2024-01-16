import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.text2,
    this.image,
    required this.screenHeight,
  }) : super(key: key);
  
  final String? text, image, text2;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image!,
          height: screenHeight * 0.25, // Adjusted size
          width: double.infinity,
        ),
        SizedBox(
          height: screenHeight * 0.04, // Adjusted size
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02, // Adjusted size
        ),
        Text(
          text2!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 183, 183, 183),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
