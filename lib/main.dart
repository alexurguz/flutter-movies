import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/movie_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      title: 'Movies',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext) => HomePage(),
        'detail' : (BuildContext) => MovieDetail()
      },
    );
  }
}