import 'package:flutter/material.dart';
import 'package:flooter/models/table_model.dart'; // Import the TableItem model
import 'package:flooter/Services/api_service.dart';

class StandingPage extends StatefulWidget {
  const StandingPage({Key? key}) : super(key: key);

  @override
  _StandingPageState createState() => _StandingPageState();
}

class _StandingPageState extends State<StandingPage> {
  late List<TableItem>? _standings = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _standings = await ApiService().getCompetitionStandings("PL") ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Standings'),
      ),
      body: _standings == null || _standings!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _standings!.length,
              itemBuilder: (context, index) {
                // Access specific properties of the TableItem class
                TableItem standing = _standings![index];
                String teamName = standing.team?.name ?? 'Unknown Team';
                int position = standing.position ?? 0;
                int playedGames = standing.playedGames ?? 0;
                int won = standing.won ?? 0;
                int drawn = standing.draw ?? 0;
                int lost = standing.lost ?? 0;
                int points = standing.points ?? 0;

                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Position: $position'),
                          Text('Team: $teamName'),
                          Text('Played: $playedGames'),
                          Text('Won: $won'),
                          Text('Drawn: $drawn'),
                          Text('Lost: $lost'),
                          Text('Points: $points'),
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
