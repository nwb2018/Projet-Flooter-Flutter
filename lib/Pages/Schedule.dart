import 'package:flooter/Pages/Schedule/widgets/competition_card.dart';
import 'package:flooter/Pages/Schedule/widgets/filter.dart';
import 'package:flooter/Pages/Schedule/widgets/search_bar.dart';
import 'package:flooter/Services/api_service.dart';
import 'package:flooter/models/match_model.dart';
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
  final List<String> _competitionIds = ['2015', '2021', '2019', '2014', '2017'];
  DateTime? _chosenDay, _medianDay;
  List<CustomDay> _dayRange = [];
  String? selectedFilter;
  List<Match>? _matches = [];
  String _searchText = '';

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

  String formatDateTime(DateTime dateTime) {
    String year = dateTime.year.toString().padLeft(4, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  List<Match>? filteredMatches(DateTime? day, String competitionId) {
    List<Match>? filteredList = _matches!.where((match) {
      // Compare dates based on year, month, and day
      DateTime matchDate = DateTime.parse(match.utcDate);
      bool isSameDate = matchDate.year == day?.year &&
          matchDate.month == day!.month &&
          matchDate.day == day.day;

      // Check if the competitionId matches
      bool isSameCompetition = match.competitionId == int.parse(competitionId);

      if (_searchText.isNotEmpty) {
        bool inCompetition = match.competitionName
            .toUpperCase()
            .contains(_searchText.toUpperCase());
        return inCompetition && isSameCompetition && isSameDate;
      }

      return isSameDate && isSameCompetition;
    }).toList();

    return filteredList.isNotEmpty ? filteredList : null;
  }

  void _getData(DateTime from, DateTime to) async {
    _matches = await ApiService().getMatches(
        competitionIds: _competitionIds,
        dateFrom: formatDateTime(from),
        dateTo: formatDateTime(to));
    print("_matches");
    print(_matches);
    setState(() {});
    // print("Getting match list");
  }

  @override
  void initState() {
    _chosenDay = DateTime.now().toLocal();
    _medianDay = _chosenDay;
    _dayRange = _selectedDays(_chosenDay!);
    _getData(_chosenDay!.subtract(const Duration(days: 5)),
        _chosenDay!.add(const Duration(days: 5)));
    super.initState();
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
            Row(children: [
              for (int index = 0; index < _dayRange.length; index++)
                CustomDate(
                    customDay: _dayRange[index],
                    onTap: (chosenDay) {
                      setState(() {
                        if (chosenDay.isBefore(_medianDay!
                                .subtract(const Duration(days: 5))) ||
                            chosenDay.isAfter(
                                _medianDay!.add(const Duration(days: 4)))) {
                          _getData(chosenDay.subtract(const Duration(days: 5)),
                              chosenDay.add(const Duration(days: 5)));
                          _medianDay = chosenDay;
                        }
                        _toggleSelectedDay(chosenDay);
                        _chosenDay = chosenDay;
                      });
                    }),
              CustomDatePicker(updateRange: (newDate) {
                setState(() {
                  if (newDate.isBefore(
                          _medianDay!.subtract(const Duration(days: 5))) ||
                      newDate
                          .isAfter(_medianDay!.add(const Duration(days: 4)))) {
                    _getData(newDate.subtract(const Duration(days: 5)),
                        newDate.add(const Duration(days: 5)));
                    _medianDay = newDate;
                  }
                  _chosenDay = newDate;
                  _dayRange = _selectedDays(newDate);
                });
              }),
            ]),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                MySearchBar(
                  onSearchChange: (String value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                const MyFilter(),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: _matches == null || _matches!.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _competitionIds.length,
                      itemBuilder: (context, index) {
                        /* return filteredMatches(_chosenDay, _competitionIds[index]) != null
                       ? CompetitionCard(matches: filteredMatches(_chosenDay, _competitionIds[index]))
                       : null; */
                        return CompetitionCard(
                            matches: filteredMatches(
                                _chosenDay, _competitionIds[index]));
                      }),
            ),
          ]),
        ));
  }
}
