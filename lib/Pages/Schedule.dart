import 'package:flooter/Pages/Schedule/widgets/filter.dart';
import 'package:flooter/Pages/Schedule/widgets/league_tile.dart';
import 'package:flooter/Pages/Schedule/widgets/match_tile.dart';
import 'package:flooter/Pages/Schedule/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'Schedule/Widgets/date_picker.dart';
import 'Schedule/models/custom_day.dart';
import 'Schedule/widgets/custom_date.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime? _chosenDay;
  List<CustomDay> _dayRange = [];
  String? selectedFilter;

  List<CustomDay> _selectedDays(DateTime chosenDay) {
    List<CustomDay> days = [];
    for (int i = -2; i <= 2; i++) {
      DateTime currentDay = chosenDay.add(Duration(days: i));
      bool isSelected = (i == 0); // Mark only the chosen day as selected
      days.add(CustomDay(currentDay, isSelected));
    }
    return days;
  }

  void _toggleSelectedDay(DateTime chosenDay) {
    for (int i = 0; i < _dayRange.length; i++) {
      if (_dayRange[i].date.compareTo(chosenDay) == 0) {
        _dayRange[i].selected = true;
      } else {
        _dayRange[i].selected = false;
      }
    }
  }

  @override
  void initState() {
    _chosenDay = DateTime.now().toLocal();
    _dayRange = _selectedDays(_chosenDay!);
    super.initState();
    // print("Initialised");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Match Schedule',
            style: TextStyle(
              color: Color(0xFF23262D),
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0.07,
            ),
          ),
        ),
        // backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              children: [
                for (int index = 0; index < _dayRange.length; index++)
                  CustomDate(
                      customDay: _dayRange[index!],
                      onTap: (chosenDay) {
                        setState(() {
                          _toggleSelectedDay(chosenDay);
                        });
                      }),
                CustomDatePicker(updateRange: (newDate) {
                  setState(() {
                    _chosenDay = newDate;
                    _dayRange = _selectedDays(newDate);
                  });
                }),
            ]),
            const SizedBox(height: 16,),
            const Row(
              children: [
                MySearchBar(),
                SizedBox(width: 8,),
                MyFilter(),
              ],
            ),
            const SizedBox(height: 8,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: tileContainerDecoration(),
                        child: Column(
                          children: [
                            LeagueTile(),
                            MatchTile(),
                            MatchTile()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
              ],
            )

          ]),
        ));
  }

  ShapeDecoration tileContainerDecoration() {
    return ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          width: 1.5,
          strokeAlign: BorderSide.strokeAlignOutside,
          color: Color(0xFFF1F1F1),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
