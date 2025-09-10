import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_programming_test/main.dart';
import 'package:speed_programming_test/widget/film_tile.dart';
import 'film_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteFilmsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Films', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: favoriteProvider.favoriteFilms.isEmpty
          ? const Center(
              child: Text(
                'No favorite films yet.',
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: favoriteProvider.favoriteFilms.length,
              itemBuilder: (context, index) {
                final film = favoriteProvider.favoriteFilms[index];
                return FilmTile(
                  film: film,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilmDetailPage(film: film),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}