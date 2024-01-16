import 'package:flooter/Pages/Home.dart';
import 'package:flooter/Pages/Match_competition.dart';
import 'package:flooter/Pages/Schedule.dart';
import 'package:flooter/Pages/Standing_competition.dart';
import 'package:flooter/Splash/splash_screen.dart';
import 'package:flooter/pages/Favoris.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECLUBS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      debugShowCheckedModeBanner:
          false, // Set this to false to remove the debug banner
      routes: {
          '/home': (context) => const MyHomePage(
              title: "salem",
            ),
        '/splash': (context) => SplashScreen(),
      
        '/schedule': (context) => const Schedule(),
        '/match': (context) => const MatchPage(),
        '/standing': (context) => const StandingPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int selectedIndex = 0;

  void _itemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  final List<Widget> _screens = [
    HomePage(),
    Schedule(),
    FavoritePage()
    // Add other pages here as needed
  ];

  void _onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: navbar,
    );
  }

  Widget get navbar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        onTap: _itemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Color.fromARGB(255, 192, 192, 192),
        selectedItemColor: Color.fromARGB(255, 96, 131, 255),
        iconSize: 20,
        selectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          fontFamily: "Poppins",
          letterSpacing: 0.5,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.home,
                size: 25,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.date_range,
                size: 25,
              ),
            ),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.star,
                size: 25,
              ),
            ),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
