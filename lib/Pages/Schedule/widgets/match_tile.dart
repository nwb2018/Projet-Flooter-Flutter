import 'package:flutter/material.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
              decoration: tileContainerDecoration(),
              child: Row(
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.adobe_rounded,
                              size: 20,
                            ),
                            //SizedBox(height: 8,),
                            Icon(
                              Icons.bathroom_rounded,
                              size: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Manchester City",
                              style: TextStyle(
                                color: Color(0xFF23262D),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Arsenal',
                              style: TextStyle(
                                color: Color(0xFF23262D),
                                fontSize: 11,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 50,
                      width: 50,
                      padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
                      //decoration: tileContainerDecoration(),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("1"),
                                //SizedBox(height: 8,),
                                Text("1"),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              )),
        ),
      ],
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
