import 'package:flutter/material.dart';

class matches extends StatelessWidget {
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  // Ajout d'une variable pour l'espacement entre la deuxième et la troisième colonne
  final double spacingBetweenColumns = 16.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            // Remplacez les valeurs par les données réelles de votre modèle de match
            String team1Logo = 'path/to/team1_logo.png';
            String team1Name = 'Team 1';
            String matchTime = '12:00 PM';
            String score1 = '2';
            String team2Logo = 'path/to/team2_logo.png';
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
                          // Image.asset(team1Logo, height: 30, width: 30),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              team1Name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: spacingBetweenColumns), // Espacement
                          Text('$score1'),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              matchTime, // Affichage du temps dans la deuxième ligne
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Ajout d'un espace entre la deuxième et la troisième colonne
                    SizedBox(height: spacingBetweenColumns),
                    ListTile(
                      title: Row(
                        children: [
                          // Image.asset(team2Logo, height: 30, width: 30),
                          SizedBox(width: spacingBetweenColumns), // Espacement
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
                    Divider(height: 0,), // Séparateur entre les matchs
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
