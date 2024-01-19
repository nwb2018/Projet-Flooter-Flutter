import 'package:flooter/Pages/League/tabs/standings.dart';
import 'package:flooter/Services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flooter/models/match_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverView extends StatefulWidget {
  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<OverView> {
  List<Match>? _matches = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _matches = await ApiService().getCompetitionMatches("2003", 1) ?? [];
    print(_matches);
    setState(() {});
  }

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
            const Text.rich(
              TextSpan(
                text: 'Hello', // default text style
                children: <TextSpan>[
                  TextSpan(
                      text: ' beautiful ',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(
                    text: 'world',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _matches!.length == 0
              ? Center(
                child: CircularProgressIndicator(),
              ):
              ListView.builder(
                itemCount: showMoreClicked
                    ? _matches!.length
                    : initialDataCount, //+ dataToAdd,
                itemBuilder: (context, index) {
                  // Remplacez le contenu par les données réelles de votre modèle de match
                  Match match = _matches![index];
                  String homeTeamName =
                      match.homeTeam?.name ?? 'Unknown Home Team';
                  String awayTeamName =
                      match.awayTeam?.name ?? 'Unknown Away Team';
                  String homeTeamScore =
                      match.score?.homeTeamScore.toString() ?? 'Unknown home Team score';
                  String matchTeamDuration =
                      match.matchday?.toString() ?? 'Unknown match duration';
                  String awayTeamScore =
                      match.score?.awayTeamScore.toString() ?? 'Unknown Away Team score';

                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                SizedBox(width: 4.0),
                                crestImage(match.homeTeam.crest),
                                Expanded(
                                  child: Text(
                                    homeTeamName.toString(),
                                    overflow: TextOverflow
                                        .ellipsis, //si le texte est trop long pour tenir dans la zone spécifiée, il sera coupé et remplacé par des points de suspension
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Text(homeTeamScore),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    matchTeamDuration,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.0),
                          ListTile(
                            title: Row(
                              children: [
                                SizedBox(width: 4.0),
                                crestImage(match.awayTeam.crest),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Text(
                                    awayTeamName.toString(),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 4.0),
                                Text(awayTeamScore),
                              ],
                            ),
                          ),
                          Divider(
                            height: 4.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
                  child: const Center(
                    child: Text(
                      "Afficher plus",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 4,
            ),
            Flexible(
                //fit: FlexFit.loose,
                child: Standings(showHeading: true)),
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
