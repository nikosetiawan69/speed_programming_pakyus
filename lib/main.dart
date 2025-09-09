import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Movie {
  final int id;
  final String title;
  final int year;
  final String genre;
  final String synopsis;
  final String posterUrl; // using placeholder images for simplicity

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.synopsis,
    required this.posterUrl,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // "Favorit" hanya disimpan sementara di memori (selama aplikasi berjalan)
  final Set<int> _favoriteIds = <int>{};

  // Data film statis (>=5)
  final List<Movie> _movies = const [
    Movie(
      id: 1,
      title: 'Interstellar',
      year: 2014,
      genre: 'Sci‑Fi, Adventure',
      synopsis:
          'Seorang mantan pilot NASA bergabung dalam misi untuk menemukan planet baru demi kelangsungan hidup umat manusia.',
      posterUrl: 'https://picsum.photos/id/1011/400/600',
    ),
    Movie(
      id: 2,
      title: 'Inception',
      year: 2010,
      genre: 'Sci‑Fi, Thriller',
      synopsis:
          'Pencuri profesional memasuki mimpi orang lain untuk menanamkan ide, tetapi realitas dan mimpi mulai bercampur.',
      posterUrl: 'https://picsum.photos/id/1005/400/600',
    ),
    Movie(
      id: 3,
      title: 'The Dark Knight',
      year: 2008,
      genre: 'Action, Crime',
      synopsis:
          'Batman menghadapi Joker, penjahat kacau yang menguji batas moral Gotham dan Sang Ksatria Kegelapan.',
      posterUrl: 'https://picsum.photos/id/1003/400/600',
    ),
    Movie(
      id: 4,
      title: 'Spirited Away',
      year: 2001,
      genre: 'Animation, Fantasy',
      synopsis:
          'Seorang gadis kecil terjebak di dunia roh dan harus bekerja di pemandian untuk menyelamatkan orang tuanya.',
      posterUrl: 'https://picsum.photos/id/1025/400/600',
    ),
    Movie(
      id: 5,
      title: 'The Matrix',
      year: 1999,
      genre: 'Sci‑Fi, Action',
      synopsis:
          'Seorang hacker mengetahui bahwa realitas yang ia kenal adalah simulasi dan bergabung dengan pemberontakan.',
      posterUrl: 'https://picsum.photos/id/1015/400/600',
    ),
  ];

  void _toggleFavorite(int movieId) {
    setState(() {
      if (_favoriteIds.contains(movieId)) {
        _favoriteIds.remove(movieId);
      } else {
        _favoriteIds.add(movieId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Film Favorit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: HomePage(
        movies: _movies,
        favoriteIds: _favoriteIds,
        onToggleFavorite: _toggleFavorite,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Movie> movies;
  final Set<int> favoriteIds;
  final void Function(int movieId) onToggleFavorite;

  const HomePage({
    super.key,
    required this.movies,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Daftar Film'),
        actions: [
          IconButton(
            tooltip: 'Lihat Favorit',
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.favorite),
                if (favoriteIds.isNotEmpty)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        favoriteIds.length.toString(),
                        style: const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesPage(
                    movies: movies
                        .where((m) => favoriteIds.contains(m.id))
                        .toList(),
                    favoriteIds: favoriteIds,
                    onToggleFavorite: onToggleFavorite,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isFav = favoriteIds.contains(movie.id);
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(
                    movie: movie,
                    isFavorite: isFav,
                    onToggleFavorite: () => onToggleFavorite(movie.id),
                  ),
                ),
              );
            },
            child: Card(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  // Poster
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const ColoredBox(
                        color: Colors.black12,
                        child: Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text('Tahun: ${movie.year}'),
                          const SizedBox(height: 6),
                          Text(
                            movie.genre,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                    color: isFav ? Colors.red : null,
                    onPressed: () => onToggleFavorite(movie.id),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Movie movie;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailPage({
    super.key,
    required this.movie,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onToggleFavorite,
        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
        label: Text(isFavorite ? 'Hapus Favorit' : 'Tambah ke Favorit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2/3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: Colors.black12,
                    child: Center(child: Icon(Icons.broken_image, size: 48)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(label: Text('Tahun ${movie.year}')),
                const SizedBox(width: 8),
                Chip(label: Text(movie.genre)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Sinopsis',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              movie.synopsis,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Movie> movies;
  final Set<int> favoriteIds;
  final void Function(int movieId) onToggleFavorite;

  const FavoritesPage({
    super.key,
    required this.movies,
    required this.favoriteIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorit Saya')),
      body: movies.isEmpty
          ? const Center(child: Text('Belum ada film favorit'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final movie = movies[index];
                final isFav = favoriteIds.contains(movie.id);
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        movie.posterUrl,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox(
                          width: 50,
                          height: 70,
                          child: ColoredBox(color: Colors.black12),
                        ),
                      ),
                    ),
                    title: Text(movie.title),
                    subtitle: Text('Tahun: ${movie.year} • ${movie.genre}'),
                    trailing: IconButton(
                      tooltip: isFav ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                      icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                      color: isFav ? Colors.red : null,
                      onPressed: () => onToggleFavorite(movie.id),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(
                            movie: movie,
                            isFavorite: isFav,
                            onToggleFavorite: () => onToggleFavorite(movie.id),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
