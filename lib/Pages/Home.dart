import 'package:flutter/material.dart';
import 'package:flooter/Services/api_service.dart';
import 'package:flooter/models/competition_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CompetitionModel> _competitions = [];
  List<CompetitionModel> _filteredCompetitions = [];

  List<Map<String, String>> staticNews = [
    {
      'news': 'Manchester United \'extremely close\' to signing Darwin Nunez',
      'imageUrl':
          'https://th.bing.com/th/id/R.786987a667c6e5c5aeddc855795dce3d?rik=dkU8%2bXDlmVtANw&pid=ImgRaw&r=0',
    },
    {
      'news': 'Barcelona set to announce new head coach next week',
      'imageUrl':
          'https://th.bing.com/th/id/R.786987a667c6e5c5aeddc855795dce3d?rik=dkU8%2bXDlmVtANw&pid=ImgRaw&r=0',
    },
    {
      'news': 'Premier League announces new TV rights deal for upcoming season',
      'imageUrl':
          'https://th.bing.com/th/id/R.786987a667c6e5c5aeddc855795dce3d?rik=dkU8%2bXDlmVtANw&pid=ImgRaw&r=0',
    },
  ];

  late List<Map<String, String>> _featuredNews = [];

  @override
  void initState() {
    super.initState();
    _getData();
    _loadFeaturedNews();
  }

  void _getData() async {
    final List<CompetitionModel> competitions =
        (await ApiService().getCompetitions())!;
    final String userCountry = (await ApiService().getUserCountry())!;

    setState(() {
      // Sort competitions putting the user's country's competition first
      competitions.sort((a, b) {
        if (a.area.name == userCountry) {
          return -1;
        } else if (b.area.name == userCountry) {
          return 1;
        } else {
          return a.name.compareTo(b.name);
        }
      });

      _competitions = competitions;
      _filteredCompetitions = competitions;
    });
  }

  void _loadFeaturedNews() {
    setState(() {
      _featuredNews = List.from(staticNews);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What’s on your mind?',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(35, 38, 45, 1),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              SearchBar(
                competitions: _competitions,
                onSearch: (filteredCompetitions) {
                  setState(() {
                    _filteredCompetitions = filteredCompetitions;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Leagues',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(35, 38, 45, 1),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 140,
                child: LeagueList(competitions: _filteredCompetitions),
              ),
              SizedBox(height: 20),
              Text(
                'Featured news',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(35, 38, 45, 1),
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  children: _featuredNews
                      .map((news) => FeaturedNewsCard(
                            news: news['news']!,
                            imageUrl: news['imageUrl']!,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeagueList extends StatefulWidget {
  final List<CompetitionModel> competitions;

  const LeagueList({Key? key, required this.competitions}) : super(key: key);

  @override
  _LeagueListState createState() => _LeagueListState();
}

class _LeagueListState extends State<LeagueList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount:
          widget.competitions.where((comp) => comp.emblem.isNotEmpty).length,
      itemBuilder: (context, index) {
        final filteredCompetitions = widget.competitions
            .where((comp) => comp.emblem.isNotEmpty)
            .toList();
        return Container(
          width: 140,
          height: 10,
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: LeagueCard(
            competition: filteredCompetitions[index],
            cardWidth: 140,
            cardHeight: 50,
          ),
        );
      },
    );
  }
}

class LeagueCard extends StatelessWidget {
  final CompetitionModel competition;
  final double cardWidth;
  final double cardHeight;

  const LeagueCard({
    required this.competition,
    required this.cardWidth,
    required this.cardHeight,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (competition.emblem.isEmpty) {
      return SizedBox.shrink();
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white),
      ),
      child: Container(
        color: Colors.white,
        width: cardWidth,
        height: cardHeight,
        child: Image.network(
          competition.emblem,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final Function(List<CompetitionModel>) onSearch;
  final List<CompetitionModel> competitions;

  const SearchBar(
      {Key? key, required this.onSearch, required this.competitions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromRGBO(241, 241, 241, 1),
        border: Border.all(
          color: const Color.fromRGBO(219, 220, 221, 1),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(
            Icons.search,
            color: Color.fromRGBO(147, 149, 152, 1),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: (value) {
                onSearch(competitions
                    .where((comp) =>
                        comp.name.toLowerCase().contains(value.toLowerCase()))
                    .toList());
              },
              style: TextStyle(
                color: Color.fromRGBO(147, 149, 152, 1),
                fontFamily: 'Inter',
                fontSize: 14,
                letterSpacing: 0,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
              decoration: const InputDecoration(
                hintText: 'Search matches, player, club and news',
                hintStyle: TextStyle(
                  color: Color.fromRGBO(147, 149, 152, 1),
                  fontFamily: 'Inter',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedNewsCard extends StatelessWidget {
  final String news;
  final String imageUrl;

  const FeaturedNewsCard({
    Key? key,
    required this.news,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              offset: Offset(0, 2),
              blurRadius: 8,
            ),
          ],
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 100,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Text(
                news,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(35, 38, 45, 1),
                  fontFamily: 'Inter',
                  fontSize: 14,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
