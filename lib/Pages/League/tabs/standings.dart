import 'package:flooter/Pages/League/tabs/Standing/custom_widgets.dart';
import 'package:flooter/Pages/League/tabs/Standing/team_tile.dart';
import 'package:flutter/material.dart';
import 'package:flooter/models/table_model.dart';
import 'package:flooter/services/api_service.dart';

class Standings extends StatefulWidget {
  const Standings({super.key, required, required this.standings, required this.isExpanded});
  final bool isExpanded;
  final List<TableItem> standings;
  
  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  // Indicateur pour vérifier si le bouton "Afficher plus" a été cliqué
  late bool showMoreClicked;

  int summaryLength(int length){
    return length>3 ? 3 : length>1 ? length/2 as int : length;
  }

  @override
  void initState() {
    showMoreClicked = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          !widget.isExpanded
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
                        itemCount: showMoreClicked ? widget.standings!.length : summaryLength(widget.standings!.length),
                        itemBuilder: (context, index) {
                          return TeamTile(standing: widget.standings![index]);
                        }
                    ),
                  ),
                  if (!showMoreClicked)
                    InkWell(
                      onTap: () {
                        // Lorsqu'on clique sur le bouton "Afficher plus", augmenter le nombre de données à afficher
                        setState(() {
                          showMoreClicked = true;
                        });
                      },
                      child: Container(
                        height: 50, // Hauteur du bouton "Afficher plus"
                        child: Center(
                          child: Text(
                            "Afficher plus",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
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