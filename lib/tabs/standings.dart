import 'package:flutter/material.dart';
import 'package:flooter/models/table_model.dart';
import 'package:flooter/services/api_service.dart';

class standings extends StatefulWidget {
  const standings({Key? key}) : super(key: key);

  @override
  State<standings> createState() => _StandingsState();
}

class _StandingsState extends State<standings> {
  late List<TableItem>? _standings = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    ApiService apiService = ApiService();
    _standings = await apiService.getCompetitionStandings("PL") ?? [];
    print(_standings);
    setState(() {});
  }

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
                expandedHeight: 50.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Colors.indigoAccent,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    if (index == 0) {
                      return SizedBox.shrink();
                    } else {
                      return buildRow(index - 1);
                    }
                  },
                  childCount: _standings!.length + 1,
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
        buildCell('Team'),
        buildCell('Positon'),
        buildCell('Played'),
        buildCell('Won'),
        buildCell('Drawn'),
        buildCell('Lost'),
        buildCell('Points'),
        buildCell('GoalsFor'),
        buildCell('GoalsAgainst'),
      ],
    );
  }

  Widget buildRow(int index) {
    TableItem tableItem = _standings![index];
    return Row(
      children: [
        buildCell(tableItem.team as String),
        buildCell(tableItem.position as String),
        buildCell(tableItem.playedGames as String),
        buildCell(tableItem.won as String),
        buildCell(tableItem.draw as String),
        buildCell(tableItem.lost as String),
        buildCell(tableItem.points as String),
        buildCell(tableItem.goalsFor as String),
        buildCell(tableItem.goalsAgainst as String),
      ],
    );
  }

  Widget buildCell(String data) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Text(
          data,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
