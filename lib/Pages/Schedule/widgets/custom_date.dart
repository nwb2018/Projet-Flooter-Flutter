import 'package:flutter/material.dart';

import '../models/custom_day.dart';

class CustomDate extends StatelessWidget {
  const CustomDate({super.key, required this.customDay, required this.onTap});
  final CustomDay customDay;
  final Function(DateTime) onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0,0,8,0),
        child: GestureDetector(
          onTap: (){
            onTap(customDay.date);
          },
          child: Container(
            height: 72,
            decoration: ShapeDecoration(
              color: customDay.selected ? const Color(0xFF3766CF) : const Color(0xFFF1F1F1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _getDayOfWeek(customDay.date),
                  style: TextStyle(
                    color: customDay.selected ? Colors.white : const Color(0xFF939598),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 0.10,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  customDay.date.day.toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: customDay.selected ? Colors.white : const Color(0xFF939598),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.09,
                    letterSpacing: 0.32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDayOfWeek(DateTime date) {
    final daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return daysOfWeek[date.weekday - 1];
  }
}
