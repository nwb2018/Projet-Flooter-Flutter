import 'package:flutter/material.dart';

class MyFilter extends StatefulWidget {
  const MyFilter({Key? key}) : super(key: key);

  @override
  State<MyFilter> createState() => _MyFilterState();
}

class _MyFilterState extends State<MyFilter> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _updateHoverState(true),
      onExit: (_) => _updateHoverState(false),
      child: InkWell(
        onTap: () {
          print("Filter");
        },
        child: Container(
          width: 85,
          height: 33,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: ShapeDecoration(
            color: isHovered? const Color(0xFFDBDCDD) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 8,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.filter_alt_outlined,
                  size: 20,
                  color: isHovered ? Colors.blue : const Color(0xFF34363D),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'Filter',
                style: TextStyle(
                  color: isHovered ? Colors.blue : const Color(0xFF34363D),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0.07,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateHoverState(bool hoverState) {
    setState(() {
      isHovered = hoverState;
    });
  }
}
