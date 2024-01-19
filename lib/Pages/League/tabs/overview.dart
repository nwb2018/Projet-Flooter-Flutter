import 'package:flooter/Pages/League/tabs/standings.dart';
import 'package:flutter/material.dart';
import 'package:flooter/models/match_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/table_model.dart';
import 'matches.dart';

class Overview extends StatefulWidget {
  const Overview({super.key, required this.matches, required this.standings});
  final List<TableItem> standings;
  final List<Match> matches;

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  // Nombre initial de données à afficher
  int initialDataCount = 4;

  // Nombre de données à ajouter à chaque clic sur "Afficher plus"
  //int dataToAdd = 5;

  // Indicateur pour vérifier si le bouton "Afficher plus" a été cliqué
  bool showMoreClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //week 31
            Expanded(child: Matches(matches: widget.matches, isExpanded: false)),
                        
            const SizedBox(height: 4,),
                        
            Expanded(child: Standings(standings: widget.standings, isExpanded: false)),
          ],
        ),
      ),
    );
  }

  Widget crestImage(String crest) {
    return (crest.endsWith('.svg'))
        ? SvgPicture.network(crest, height: 20, width: 20)
        : Image.network(crest, height: 20, width: 20);
  }
}
