import 'package:flutter/material.dart';
import 'package:flooter/Services/api_service.dart';
import 'package:flooter/models/match_model.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late List<Match>? _matches = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _matches = await ApiService().getMatches(
  competitionIds: ['2015', '2021', '2019', '2017'],
  dateFrom: '2022-05-17',
  dateTo: '2022-05-21',
);
    setState(() {});
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Football Matches'),
    ),
    body: _matches == null || _matches!.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: _matches!.length,
            itemBuilder: (context, index) {
              Match match = _matches![index];
              String homeTeamName =
                  match.homeTeam?.name ?? 'Unknown Home Team';
              String awayTeamName =
                  match.awayTeam?.name ?? 'Unknown Away Team';
              String matchDate = match.utcDate.toString() ??
                  'Unknown Date'; // Utilisation de la date UTC
              // String leagueName = match.competition?.name ?? 'Unknown League';
              String scoreText = '${match.score?.homeTeamScore ?? 0} - ${match.score?.awayTeamScore ?? 0}';

              return Card(
                child: ListTile(
                  title: Text('$homeTeamName vs $awayTeamName'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('League: $leagueName'),
                      Text('Date: $matchDate'),
                      Text('Score: $scoreText'),
                    ],
                  ),
                ),
              );
            },
          ),
  );
}

}