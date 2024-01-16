import 'package:flooter/Pages/Schedule/widgets/league_tile.dart';
import 'package:flooter/Pages/Schedule/widgets/match_tile.dart';
import 'package:flutter/material.dart';
import 'package:flooter/models/match_model.dart';

class CompetitionCard extends StatefulWidget {
  const CompetitionCard({super.key, required this.matches});
  final List<Match>? matches;

  @override
  State<CompetitionCard> createState() => _CompetitionCardState();
}

class _CompetitionCardState extends State<CompetitionCard>
    with TickerProviderStateMixin {
  bool isExpanded = true;
  late AnimationController _sizeController;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
      value: isExpanded ? 1.0 : 0.0, // Set the initial value based on isExpanded
    );
  }


  @override
  void dispose() {
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.matches == null || widget.matches!.isEmpty
        ? const Center(child: null)
        : Padding(
      padding: const EdgeInsets.fromLTRB(1, 0, 1, 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: tileContainerDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LeagueTile(
                    emblem: widget.matches![0].competitionEmblem,
                    name: widget.matches![0].competitionName,
                     area: widget.matches![0].area,
                    toggleExpanded: () {
                      setState(() {
                        isExpanded = !isExpanded;
                        if (isExpanded) {
                          _sizeController.forward();
                        } else {
                          _sizeController.reverse();
                        }
                      });
                    },
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    // vsync: this,
                    child: isExpanded
                        ? SizeTransition(
                      sizeFactor: _sizeController,
                      axisAlignment: 0.0,
                      child: Column(
                        children: [
                          for (int i = 0;
                          i < widget.matches!.length;
                          i++)
                            MatchTile(
                                match: widget.matches![i]),
                        ],
                      ),
                    )
                        : const SizedBox(height: 0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
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

