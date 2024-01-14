import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 33,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color: const Color(0xFFF1F1F1),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFDBDCDD),
            ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: const TextField(
          maxLength: 20, // Set the maximum number of characters
          //maxLines: 1,
          decoration: InputDecoration(
            icon: Icon(
              Icons.manage_search,
              size: 20,
              color: Color(0xFF939598),
            ),
            hintText: 'Search',
            hintStyle: TextStyle(
              color: Color(0xFF939598),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              height: 0.07,
            ),
            border: InputBorder.none,
            counterText: '',
          ),
        ),
      ),
    );
  }

}
