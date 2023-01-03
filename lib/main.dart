import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _searchController = TextEditingController();
  List<Movie> _movies = [
    Movie('Avatar 1', 4.5, 'Action', 'https://picsum.photos/250?image=10'),
    Movie('Avatar 2', 3.5, 'Danse', 'https://picsum.photos/250?image=11'),
    Movie('Avatar 3', 2.5, 'Humour', 'https://picsum.photos/250?image=12'),
    Movie('Avatar 4', 5.0, 'Action', 'https://picsum.photos/250?image=13'),
    Movie('Avatar 5', 3.0, 'Action', 'https://picsum.photos/250?image=14'),
  ];
  List<Movie> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _filteredMovies = _movies
                  .where((movie) =>
                      movie.title.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
        ),
        actions: [
          BackButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _filteredMovies = _movies;
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        itemCount: _filteredMovies.length,
        itemBuilder: (context, index) {
          return GridTile(
            child: InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MovieDetailPage(_filteredMovies[index]),
                  ),
                );
              },
              child: Stack(
                children: [
                  Image.network(_filteredMovies[index].imageUrl),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _filteredMovies[index].title,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(movie.imageUrl),
            SizedBox(height: 8),
            Text(
              movie.title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${movie.rating}/10' + ' ⭐',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Movie {
  final String title;
  final double rating;
  final String genre;
  final String imageUrl;

  Movie(this.title, this.rating, this.genre,this.imageUrl);
}
