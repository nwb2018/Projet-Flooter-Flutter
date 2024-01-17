import 'package:flooter/Pages/League/tabs/Standing/custom_widgets.dart';
import 'package:flooter/Pages/League/tabs/Standing/team_tile.dart';
import 'package:flutter/material.dart';
import 'package:flooter/models/table_model.dart';
import 'package:flooter/services/api_service.dart';

class Standings extends StatefulWidget {
  const Standings({super.key, required, required this.showHeading});
  final bool showHeading;
  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  List<TableItem>? _standings = [];

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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.showHeading
          ? Text(
              'Standings',
              style: customTextStyle(14, FontWeight.w700),
            )
          : const Center( child: null),
          const SizedBox(height: 18),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFFF1F1F1),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: customBoxDecoration(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                child: Text(
                                    '#',
                                    textAlign: TextAlign.center,
                                    style: customTextStyle(12, FontWeight.w400)
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                  'Team',
                                  style: customTextStyle(12, FontWeight.w400)
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2,),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              standingTab('M', 20, false),
                              standingTab('W', 20, false),
                              standingTab('D', 20, false),
                              standingTab('L', 20, false),
                              standingTab('G', 40, false),
                              standingTab('PTS', 25, true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
                  Flexible(
                    fit: FlexFit.loose,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _standings!.length,
                        itemBuilder: (context, index) {
                          return TeamTile(standing: _standings![index]);
                        }
                    ),
                  ),

                  const SizedBox(height: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                'See All',
                                style: customTextStyle(12, FontWeight.w400)
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.chevron_right,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}