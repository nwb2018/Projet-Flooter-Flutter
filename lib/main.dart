import 'package:flooter/pages/Favoris.dart';
import 'package:flooter/pages/Home.dart';
import 'package:flooter/Pages/Match_competition.dart';
import 'package:flooter/Pages/Schedule.dart';
import 'package:flooter/Pages/Standing_competition.dart';
import 'package:flooter/Splash/splash_screen.dart';
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
      initialRoute: '/',
      routes: {
        //  '/': (context) => SplashScreen(),
        ///'/': (context) => const HomePage(),
        // '/': (context) => const MatchPage(),
        '/': (context) => FavoritePage(),
        //'/': (context) => const StandingPage(),
        '/schedule': (context) => const Schedule(),
      },
    );
  }
}
