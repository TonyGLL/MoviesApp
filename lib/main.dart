import 'package:peliculas_07/src/pages/home_page.dart';

/* ROUTES */
import 'package:flutter/material.dart';
import 'package:peliculas_07/src/pages/movie_details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Homepage(),
        'details': (BuildContext context) => MovieDetails()
      },
    );
  }
}
