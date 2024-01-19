import 'package:flooter/Pages/Schedule/widgets/match_tile.dart';
import 'package:flooter/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flooter/models/match_model.dart';


class Matches extends StatefulWidget {
  const Matches({super.key, required this.matches, required this.isExpanded});
  final List<Match> matches;
  final bool isExpanded;
  
  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  List<int> _matchdays = [];

  int summaryLength(int length){
    return length>3 ? 3 : length>1 ? length/2 as int : length;
  }

  // Indicateur pour vérifier si le bouton "Afficher plus" a été cliqué
  late bool showMoreClicked;

  @override
  void initState() {
    _matchdays = widget.matches.map((match) => match.matchday).toSet().toList().reversed.toList();
    showMoreClicked = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: showMoreClicked ? _matchdays.length : 1,// showMoreClicked ? widget.matches!.length : summaryLength(widget.matches!.length),
                itemBuilder: (context, index) {
                  List<Match> filteredMatches = widget.matches.where((match) {
                    return match.matchday == _matchdays[index];
                  }).toList();

                  return Column(
                    children: [
                      Text(
                          "Week ${_matchdays[index]}",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                      ),
                      const SizedBox(height: 2,),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children : List.generate(
                          showMoreClicked? filteredMatches.length : summaryLength(filteredMatches.length),
                              (index) => MatchTile(match: filteredMatches[index]),
                        ),
                      ),
                      const SizedBox(height: 5,),
                    ],
                  );

                }
              ),
            ),
            // Afficher le bouton "Afficher plus" en dehors de la boucle
            if (!showMoreClicked)
              InkWell(
                onTap: () {
                  // Lorsqu'on clique sur le bouton "Afficher plus", augmenter le nombre de données à afficher
                  setState(() {
                    showMoreClicked = true;
                  });
                },
                child: Container(
                  height: 50, // Hauteur du bouton "Afficher plus"
                  child: Center(
                    child: Text(
                      "Afficher plus",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
          ],
        ),
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
}