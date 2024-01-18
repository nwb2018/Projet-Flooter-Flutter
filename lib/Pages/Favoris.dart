import 'package:flooter/Pages/Schedule/widgets/competition_card.dart';
import 'package:flutter/material.dart';
import 'package:flooter/Services/api_service.dart';
import 'package:flooter/models/match_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  TextEditingController _favoriteController = TextEditingController();
  late List<Match>? _matches = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int preferredTeamId =
        prefs.getInt('preferredTeamId') ?? 5; // Default to 5 if not found

    _matches = await ApiService().getMatchesByTeam(preferredTeamId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Color(0xFF23262D),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0.07,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _matches == null || _matches!.isEmpty
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _matches!.length,
                      itemBuilder: (context, index) {
                        if (_matches![index].status == 'FINISHED') {
                          return Container();
                        } else {
                          return CompetitionCard(matches: [_matches![index]]);
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
