import 'package:flooter/Pages/League/tabs/matches.dart';
import 'package:flooter/Pages/League/tabs/standings.dart';
import 'package:flooter/Pages/League/tabs/overview.dart';
import 'package:flutter/material.dart';
import 'package:flooter/models/match_model.dart';

import '../Services/api_service.dart';
import '../models/table_model.dart';




class LeaguePage extends StatefulWidget {
  // add required field competition
  const LeaguePage({super.key});

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

  void _getData() async {
    DateTime dateFrom = DateTime.now().subtract(const Duration(days: 9, hours: 12));
    DateTime dateTo = DateTime.now().add(const Duration(hours: 12));
    // pass competition Id
    _matches = await ApiService().getMatches(competitionIds: ["2003"], dateFrom: formatDateTime(dateFrom), dateTo: formatDateTime(dateTo));
    print(_matches);
    ApiService apiService = ApiService();
    // pass competition code
    _standings = await apiService.getCompetitionStandings("PL") ?? [];
    print(_standings);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Logo'),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      //const Text('LEAGUE'),
                      Row(
                        children: [Text('LEAGUE', style: TextStyle(fontWeight: FontWeight.bold)),],
                      ),
                      Row(
                        children: [Text('England',style: TextStyle(fontSize: 15),),],
                      ),
                      Row(
                        children: [Text('2021/2022', style: TextStyle(fontSize: 10),)],
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
            const Divider(height: 25,), // Séparateur bas du logo (bar)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TabBar(
                  tabs: [
                    Tab(text: 'Overview',),
                    Tab(text: 'Matches',),
                    Tab(text: 'Standings',)
                  ]
              ),
            ),

            //afficher contenu des tabs
            Expanded(
              child: TabBarView(
                  children: [

                    //overView
                    _standings!.isEmpty || _matches!.isEmpty
                    ? const Center(child: CircularProgressIndicator(),)
                    : Overview(standings: _standings!, matches: _matches!,),

                    //matches
                    _matches!.isEmpty
                    ? const Center(child: CircularProgressIndicator(),)
                    : Matches(matches: _matches!, isExpanded: true),

                    //standings
                    _standings!.isEmpty
                    ? const Center(child: CircularProgressIndicator(),)
                    : Standings(standings: _standings!, isExpanded: true,),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
