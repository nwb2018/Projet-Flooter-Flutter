import 'package:flutter/material.dart';

class overView extends StatefulWidget {
  @override
  _OverViewState createState() => _OverViewState();
}

class _OverViewState extends State<overView> {
  // Nombre initial de données à afficher
  int initialDataCount = 5;
  // Nombre de données à ajouter à chaque clic sur "Afficher plus"
  int dataToAdd = 5;
  // Indicateur pour vérifier si le bouton "Afficher plus" a été cliqué
  bool showMoreClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: showMoreClicked ? initialDataCount + dataToAdd : initialDataCount,
                itemBuilder: (context, index) {
                  // Remplacez le contenu par les données réelles de votre modèle de match
                  String team1Name = 'Team 1';
                  String matchTime = '12:00 PM';
                  String score1 = '2';
                  String team2Name = 'Team 2';
                  String score2 = '1';

                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: Row(
                              children: [
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    team1Name,
                                    overflow: TextOverflow.ellipsis, //si le texte est trop long pour tenir dans la zone spécifiée, il sera coupé et remplacé par des points de suspension
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('$score1'),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    matchTime,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          ListTile(
                            title: Row(
                              children: [
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    team2Name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('$score2'),
                              ],
                            ),
                          ),
                          Divider(height: 0,),
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
          ],
        ),
      ),
    );
  }
}