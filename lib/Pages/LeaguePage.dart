import 'package:flutter/material.dart';
import 'package:flooter/Pages/League/tabs/matches.dart';
import 'package:flooter/Pages/League/tabs/standings.dart';
import 'package:flooter/Pages/League/tabs/overview.dart';
import 'package:flooter/models/match_model.dart';
import '../Services/api_service.dart';
import '../models/table_model.dart';

class LeaguePage extends StatefulWidget {
  final int competitionId;
  final String competitionCode;

  const LeaguePage({
    required this.competitionId,
    required this.competitionCode,
    Key? key,
  }) : super(key: key);

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> {
  List<Match>? _matches = [];
  List<TableItem>? _standings = [];

  String formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    DateTime dateFrom = DateTime.now().subtract(const Duration(days: 9, hours: 12));
    DateTime dateTo = DateTime.now().add(const Duration(hours: 12));

    _matches = await ApiService().getMatches(
      competitionIds: [widget.competitionId.toString()],
      dateFrom: formatDateTime(dateFrom),
      dateTo: formatDateTime(dateTo),
    );

    ApiService apiService = ApiService();
    _standings = await apiService.getCompetitionStandings(widget.competitionCode) ?? [];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              child: Row(
                children: [
                  Column(
                    children: [
                      if (_matches?.isNotEmpty == true &&
                          _matches![0].competitionEmblem.isNotEmpty)
                        Image.network(
                          _matches![0].competitionEmblem,
                          width: 50,
                          height: 50,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )
                      else
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      if (_matches?.isNotEmpty == true)
                        Row(
                          children: [
                            Text('LEAGUE', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      if (_matches?.isNotEmpty == true)
                        Row(
                          children: [
                            Text(_matches![0].competitionName, style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      Row(
                        children: [
                          Text('2021/2022', style: TextStyle(fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            const Divider(height: 25,), // Separator below the logo (bar)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TabBar(
                tabs: [
                  Tab(
                    text: 'Overview',
                  ),
                  Tab(
                    text: 'Matches',
                  ),
                  Tab(
                    text: 'Standings',
                  )
                ],
              ),
            ),

            // Display content of the tabs
            Expanded(
              child: TabBarView(
                children: [
                  // Overview
                  _standings!.isEmpty || _matches!.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Overview(
                          standings: _standings!,
                          matches: _matches!,
                        ),

                  // Matches
                  _matches!.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Matches(
                          matches: _matches!,
                          isExpanded: true,
                        ),

                  // Standings
                  _standings!.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Standings(
                          standings: _standings!,
                          isExpanded: true,
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
