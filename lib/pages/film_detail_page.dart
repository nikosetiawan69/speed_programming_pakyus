import 'package:flutter/material.dart';
import 'package:speed_programming_test/model/film.dart';

class FilmDetailPage extends StatelessWidget {
  final Film film;

  const FilmDetailPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(film.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                film.poster,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, size: 48),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film.title,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text("Director: ${film.director}"),
                  Text("Year: ${film.year}"),
                  const SizedBox(height: 16),
                  Text(film.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
