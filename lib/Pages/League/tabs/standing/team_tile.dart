import 'package:flooter/models/table_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'custom_widgets.dart';

class TeamTile extends StatelessWidget {
  const TeamTile({super.key, required this.standing});
  final TableItem standing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: customBoxDecoration(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                      standing.position.toString(),
                      textAlign: TextAlign.center,
                      style: customTextStyle(12, FontWeight.w400)
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 122,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      crestImage(standing.team.crest),
                      const SizedBox(width: 8),
                      Text(
                          customName(standing.team.name),
                          style: customTextStyle(12, FontWeight.w400)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 2,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                standingTab(standing.playedGames.toString(), 20, false),
                standingTab(standing.won.toString(), 20, false),
                standingTab(standing.draw.toString(), 20, false),
                standingTab(standing.lost.toString(), 20, false),
                standingTab("${standing.goalsFor}:${standing.goalsAgainst}", 40, false),
                standingTab(standing.points.toString(), 25, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget crestImage(String crest){
    return (crest.endsWith('.svg'))
      ? SvgPicture.network(
        crest,
        height: 20,
        width: 20
      )
      : Image.network(
        crest,
        height: 20,
        width: 20
    );
  }

  String customName(String name) {
    if (name.length < 15) {
      return name;
    } else {
      return "${name.substring(0, 12)}...";
    }
  }

}
