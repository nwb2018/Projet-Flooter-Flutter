import 'package:flutter/material.dart';

class standings extends StatelessWidget {
  final String _id = '1';
  final String team1Logo = 'xxx';
  final String team1Name = 'Team 1';
  final String match = '38';
  final String win = '29';
  final String defeat = '6';
  final String _nul = '3';
  final String time = '99:26';
  final String pts = '93';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: buildHeader(),
                floating: true,
                pinned: true,
                expandedHeight: 50.0, // Hauteur de l'en-tête
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.indigoAccent, // Couleur qui surligne l'en-tête
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index == 0) {
                      // L'en-tête a déjà été affichée
                      return SizedBox.shrink();
                    } else {
                      // Les éléments suivants avec séparateurs
                      return buildRow(index);
                    }
                  },
                  childCount: 25, // nombre total d'éléments suivants
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      children: [
        buildCell('ID'),
        buildCell('Logo'),
        buildCell('Team'),
        buildCell('Matches'),
        buildCell('Wins'),
        buildCell('Defeats'),
        buildCell('Draws'),
        buildCell('Time'),
        buildCell('Points'),
      ],
    );
  }

  Widget buildRow(int index) {
    return Row(
      children: [
        buildCell(_id),
        buildCell(team1Logo),
        buildCell(team1Name),
        buildCell(match),
        buildCell(win),
        buildCell(defeat),
        buildCell(_nul),
        buildCell(time),
        buildCell(pts),
      ],
    );
  }

  Widget buildCell(String data) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // Ligne horizontale entre les cellules
          ),
        ),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0, // Taille du texte de l'en-tête
            color: Colors.black, // Couleur du texte de l'en-tête
          ),
        ),
      ),
    );
  }
}


