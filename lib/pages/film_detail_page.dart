import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_programming_test/main.dart';
import 'package:speed_programming_test/model/film.dart';

class FilmDetailPage extends StatelessWidget {
  final Film film;

  const FilmDetailPage({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteFilmsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(film.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              favoriteProvider.isFavorite(film) ? Icons.favorite : Icons.favorite_border,
              color: favoriteProvider.isFavorite(film) ? Colors.red : Colors.white,
            ),
            onPressed: () {
              favoriteProvider.toggleFavorite(film);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              film.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    film.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Genre: ${film.genre}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    film.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}