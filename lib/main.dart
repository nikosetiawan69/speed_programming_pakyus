import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/film_list_page.dart';
import 'package:speed_programming_test/pages/favorite.dart';
import 'package:speed_programming_test/model/film.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoriteFilmsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1C2526),
        primaryColor: const Color(0xFF8B0000),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B0000),
          secondary: Color(0xFFFFF5EE),
          surface: Color(0xFF2F4F4F),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
          headlineSmall: TextStyle(color: Color(0xFFFFF5EE), fontWeight: FontWeight.bold),
        ),
        cardColor: const Color(0xFF2F4F4F),
        iconTheme: const IconThemeData(color: Color(0xFFFFF5EE)),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const FilmListPage(),
    const FavoritesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Film',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white70,
        backgroundColor: const Color(0xFF1C2526),
        onTap: _onItemTapped,
      ),
    );
  }
}

class FavoriteFilmsProvider with ChangeNotifier {
  final List<Film> _favoriteFilms = [];

  List<Film> get favoriteFilms => _favoriteFilms;

  void toggleFavorite(Film film) {
    if (_favoriteFilms.contains(film)) {
      _favoriteFilms.remove(film);
    } else {
      _favoriteFilms.add(film);
    }
    notifyListeners();
  }

  bool isFavorite(Film film) => _favoriteFilms.contains(film);
}