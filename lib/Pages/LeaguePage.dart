import 'package:flooter/tabs/matches.dart';
import 'package:flooter/tabs/standings.dart';
import 'package:flooter/tabs/overView.dart';

import 'package:flutter/material.dart';


class LeaguePage extends StatelessWidget {
  const LeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 26,
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
                    Tab(text: 'OverView',),
                    Tab(text: 'Matches',),
                    Tab(text: 'Stansdings',)
                  ]
              ),
            ),

            //week 31
            const Text.rich(
              TextSpan(
                text: 'Hello', // default text style
                children: <TextSpan>[
                  TextSpan(text: ' beautiful ', style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(text: 'world', style: TextStyle(fontWeight: FontWeight.bold,),),
                ],
              ),
            ),

            //afficher contenu des tabs
            Expanded(
              child: TabBarView(
                  children: [

                    //overView
                    overView(),

                    //matches
                    const matches(),

                    //standings
                    const standings(),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
