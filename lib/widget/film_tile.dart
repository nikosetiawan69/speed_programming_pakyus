import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_programming_test/main.dart';
import 'package:speed_programming_test/model/film.dart';

class FilmTile extends StatelessWidget {
  final Film film;
  final VoidCallback onTap;

  const FilmTile({super.key, required this.film, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteFilmsProvider>(context);

    return Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                film.image,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      film.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      film.genre,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  favoriteProvider.isFavorite(film) ? Icons.favorite : Icons.favorite_border,
                  color: favoriteProvider.isFavorite(film) ? Colors.red : Colors.white70,
                ),
                onPressed: () {
                  favoriteProvider.toggleFavorite(film);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}