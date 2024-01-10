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
    _matches = await ApiService().getCompetitionMatches("2003", 1) ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),
      ),
      body: _matches == null || _matches!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _matches!.length,
              itemBuilder: (context, index) {
                // Access specific properties of the Match class
                Match match = _matches![index];
                String homeTeamName =
                    match.homeTeam?.name ?? 'Unknown Home Team';
                String awayTeamName =
                    match.awayTeam?.name ?? 'Unknown Away Team';
                String score = '1 - 0';

                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Home Team: $homeTeamName'),
                          Text('Away Team: $awayTeamName'),
                          Text('Score: $score'),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      // Additional widgets or information you want to display
                    ],
                  ),
                );
              },
            ),
    );
  }
}
