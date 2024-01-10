import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flooter'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Rechercher un club de foot',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              SearchBar(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: navbar,
    );
  }
}

Widget get navbar {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topRight: Radius.circular(30),
      topLeft: Radius.circular(30),
    ),
    child: BottomNavigationBar(
      //onTap: _itemTapped,
      type: BottomNavigationBarType.fixed,
      //currentIndex: selectedIndex,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      unselectedItemColor: const Color.fromARGB(255, 192, 192, 192),
      selectedItemColor: const Color.fromARGB(255, 96, 131, 255),
      iconSize: 20,
      selectedLabelStyle: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        fontFamily: "Poppins",
        letterSpacing: 0.5,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.home,
              size: 25,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.date_range,
              size: 25,
            ),
          ),
          label: "Schedule",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(
              Icons.star_border,
              size: 25,
            ),
          ),
          label: "Favoris",
        ),
      ],
    ),
  );
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Rechercher...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
