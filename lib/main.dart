import 'package:flutter/material.dart';
import 'package:speed_programming_test/pages/film_list_page.dart';
import 'package:speed_programming_test/pages/film_list_page.dart';

void main() {
  runApp(const FilmApp());
}

class FilmApp extends StatelessWidget {
  const FilmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const FilmListPage(),
    );
  }
}
