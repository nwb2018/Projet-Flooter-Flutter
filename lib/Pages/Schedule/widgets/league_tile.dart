import 'package:flutter/material.dart';

class LeagueTile extends StatelessWidget {
  const LeagueTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
              decoration: tileContainerDecoration(),
              child: const Row(
                children: [
                  Icon(Icons.filter_1),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Premiere League',
                        style: TextStyle(
                          color: Color(0xFF23262D),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      //SizedBox(height: 8,),
                      Text(
                        'England',
                        style: TextStyle(
                          color: Color(0xFF23262D),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),
        ),
        Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
            decoration: tileContainerDecoration(),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        child: const Icon(
                          Icons.arrow_drop_down,
                        ),
                      )],
                  ),
                ),],
            )
        )],
    );
  }

  ShapeDecoration tileContainerDecoration() {
    return ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1.5,
          strokeAlign: BorderSide.strokeAlignOutside,
          color: Color(0xFFF1F1F1),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
