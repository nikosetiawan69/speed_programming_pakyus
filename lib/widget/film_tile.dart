import 'package:flutter/material.dart';
import 'package:speed_programming_test/model/film.dart';
import 'package:speed_programming_test/pages/film_detail_page.dart';

class FilmTile extends StatelessWidget {
  final Film film;

  const FilmTile({super.key, required this.film});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          film.poster,
          width: 50,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 50,
              height: 70,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, size: 20),
            );
          },
        ),
      ),
      title: Text(film.title),
      subtitle: Text("${film.director} • ${film.year}"),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmDetailPage(film: film),
          ),
        );
      },
    );
  }
}
