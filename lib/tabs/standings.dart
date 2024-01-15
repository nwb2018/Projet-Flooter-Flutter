import 'package:flutter/material.dart';


class standings extends StatelessWidget {
  const standings({super.key});
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
            String team2Logo = 'path/to/team2_logo.png';
            String team2Name = 'Team 2';
            String matchTime = '12:00 PM';
            String score1 = '2';
            String score2 = '1';


            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //Image.asset(team1Logo, height: 30, width: 30),
                                SizedBox(width: 8),
                                Text(team1Name),

                                SizedBox(width: 241),
                                Text('$score1'),
                              ],
                            ),
                            Text('$matchTime'),
                          ],
                        ),
                      ),
                    ),

                    ListTile(
                      title: Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                //Image.asset(team2Logo, height: 30, width: 30),
                                SizedBox(width: 8),
                                Text(team2Name),

                                SizedBox(width: 241),
                                Text('$score2'),
                              ],
                            ),
                          ],
                        ),
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

