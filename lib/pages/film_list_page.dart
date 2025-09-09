import 'package:flutter/material.dart';
import 'package:speed_programming_test/data/sample_data.dart';
import 'package:speed_programming_test/data/sample_data.dart';
import 'package:speed_programming_test/widget/film_tile.dart';

class FilmListPage extends StatelessWidget {
  const FilmListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Film List")),
      body: ListView.builder(
        itemCount: sampleFilms.length,
        itemBuilder: (context, index) {
          return FilmTile(film: sampleFilms[index]);
        },
      ),
    );
  }
}
