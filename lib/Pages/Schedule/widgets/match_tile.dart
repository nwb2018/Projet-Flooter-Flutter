import 'package:flooter/models/match_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MatchTile extends StatelessWidget {
  const MatchTile({super.key, required this.match});
  final Match match;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              height: 70,
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
              decoration: tileContainerDecoration(),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            crestImage(match.homeTeam.crest),
                            const SizedBox(height: 12,),
                            crestImage(match.awayTeam.crest),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              match.homeTeam.name,
                              style: textStyle(12, FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              match.awayTeam.name,
                              style: textStyle(12, FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      width: 80,
                      child: match.status == 'TIMED' || match.status == 'CANCELLED'
                          ? Row(
                            children: [
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      match.status == 'TIMED'
                                      ? Text(
                                        getDateTime(match.utcDate)[0].toUpperCase(),
                                        style: textStyle(14, FontWeight.w600),
                                      )
                                      : Text(
                                        'CANCELLED',
                                        style: textStyle(10, FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      match.status == 'TIMED'
                                      ? Text(
                                          getDateTime(match.utcDate)[1],
                                          style: textStyle(14, FontWeight.w600),
                                        )
                                        : const SizedBox(),
                                    ],
                                  ),
                                ),
                            ],
                          )
                          : Row(
                              children: [
                                SizedBox(
                                  width: 30, height: 50,
                                  child: match.status!='FINISHED'
                                    ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${match.score.duration}'",
                                          style: textStyle(14, FontWeight.w600),
                                        ),
                                      ],
                                    )
                                    : const SizedBox(),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        match.score.homeTeamScore.toString(),
                                        style: match.score.winner == 'HOME_TEAM'
                                            ? const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              )
                                            : null,
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        match.score.awayTeamScore.toString(),
                                        style: match.score.winner == 'AWAY_TEAM'
                                            ? const TextStyle(
                                                fontWeight: FontWeight.w700,
                                              )
                                            : null,
                                      ),
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

  List<String> getDateTime(String utcDate) {
    DateTime parsedDateTime = DateTime.parse(utcDate).toLocal(); // Convert UTC to local time
    DateTime now = DateTime.now().toLocal();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Format date to "dd MMM"
    String formattedDate = (DateTime(parsedDateTime.year, parsedDateTime.month, parsedDateTime.day).isAfter(today))
        ? DateFormat('dd MMM').format(parsedDateTime)
        : 'TODAY';

    // Format time to "HH:mm"
    String formattedTime = DateFormat('HH:mm').format(parsedDateTime);

    return [formattedDate, formattedTime];
  }

  Widget crestImage(String crest) {
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
  }

  TextStyle textStyle(double size, FontWeight weight){
      return TextStyle(
        color: const Color(0xFF23262D),
        fontSize: size,
        fontFamily: 'Inter',
        fontWeight: weight,
      );
  }
}
