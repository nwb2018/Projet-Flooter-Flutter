import 'package:flutter/material.dart';

TextStyle customTextStyle(double size, FontWeight weight){
  return TextStyle(
    color: const Color(0xFF23262D),
    fontSize: size,
    fontFamily: 'Inter',
    fontWeight: weight,
  );
}

Widget standingTab(String value, double width, isLast){
  return SizedBox(
    width: width,
    child: Center(
      child: Text(
          value,
          textAlign: TextAlign.center,
          style: !isLast
              ? customTextStyle(12, FontWeight.w400)
              : customTextStyle(12, FontWeight.w700)
      ),
    ),
  );
}

BoxDecoration customBoxDecoration(){
  return const BoxDecoration(
    border: Border(
      left: BorderSide(
        strokeAlign: BorderSide.strokeAlignOutside,
        color: Color(0xFFF1F1F1),
      ),
      top: BorderSide(
        strokeAlign: BorderSide.strokeAlignOutside,
        color: Color(0xFFF1F1F1),
      ),
      right: BorderSide(
        strokeAlign: BorderSide.strokeAlignOutside,
        color: Color(0xFFF1F1F1),
      ),
      bottom: BorderSide(
        width: 1,
        strokeAlign: BorderSide.strokeAlignOutside,
        color: Color(0xFFF1F1F1),
      ),
    ),
  );
}