import 'package:flutter/material.dart';
import 'package:liga/presentation/pages/football_match_detailed_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liga Stavok Sport Widget',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 10, color: Colors.white),
            headline1: TextStyle(
                fontSize: 12,
                color: Color(0xff7E7E7E),
                fontWeight: FontWeight.bold),
            headline2: TextStyle(
                fontSize: 15,
                color: Color(0xff7E7E7E),
                fontWeight: FontWeight.bold),
            headline3: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 28, color: Colors.white),
            headline4: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FootballMatchDetailedPage(),
    );
  }
}
