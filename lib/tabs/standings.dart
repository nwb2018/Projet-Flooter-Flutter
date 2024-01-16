import 'package:flooter/models/team_model.dart';
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
        buildCell('Position'),
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
        buildCell(tableItem.team.name as String),
        buildCell(tableItem.position.toString() as String),
        buildCell(tableItem.playedGames.toString() as String),
        buildCell(tableItem.won.toString() as String),
        buildCell(tableItem.draw.toString() as String),
        buildCell(tableItem.lost.toString() as String),
        buildCell(tableItem.points.toString() as String),
        buildCell(tableItem.goalsFor.toString() as String),
        buildCell(tableItem.goalsAgainst.toString() as String),
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