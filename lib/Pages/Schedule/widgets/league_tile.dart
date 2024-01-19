import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeagueTile extends StatefulWidget {
  const LeagueTile({
    Key? key,
    required this.emblem,
    required this.name,
    required this.area,
    required this.toggleExpanded,
  }) : super(key: key);

  final String emblem;
  final String name;
  final String area;
  final Function() toggleExpanded;

  @override
  State<LeagueTile> createState() => _LeagueTileState();
}

class _LeagueTileState extends State<LeagueTile> {
  bool isHovered = false;
  bool isExpanded = true;

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
                crestImage(widget.emblem),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Color(0xFF23262D),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.area,
                      style: const TextStyle(
                        color: Color(0xFF23262D),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        MouseRegion(
          onEnter: (_) => _updateHoverState(true),
          onExit: (_) => _updateHoverState(false),
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
              widget.toggleExpanded();
            },
            child: Container(
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
                          child: Icon(
                            !isExpanded
                                ? Icons.arrow_drop_up_outlined
                                : Icons.arrow_drop_down_outlined,
                            color: isHovered
                                ? Colors.blue
                                : const Color(0xFF34363D),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

Widget crestImage(String crest) {
  try {
    return (crest.endsWith('.svg'))
        ? SvgPicture.network(
            crest,
            width: 20,
            height: 20,
          )
        : Image.network(
            crest,
            width: 20,
            height: 20,
          );
  } catch (e) {
    // Handle the error (e.g., log it, show a placeholder, or use a default image)
    // In this case, we will just print the error
    print('Error loading SVG/Image: $e');

    // Return a placeholder or default image widget
    return Placeholder(); // You can replace this with your desired fallback.
  }
}



  ShapeDecoration tileContainerDecoration() {
    return ShapeDecoration(
      color: isHovered ? const Color(0xFFDBDCDD) : Colors.white,
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

  void _updateHoverState(bool hoverState) {
    setState(() {
      isHovered = hoverState;
    });
  }
}
