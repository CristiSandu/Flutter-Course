import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/04/models/movie.dart';
import 'package:flutter_course/src/04/view_movie.dart';
import 'package:http/http.dart';

// ignore_for_file: file_names
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Movie> _movies = <Movie>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  Future<void> _getMovies() async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
    );

    final Response response = await get(url);
    final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> data = body['data'] as Map<String, dynamic>;
    final List<dynamic> movies = data['movies'] as List<dynamic>;

    setState(
      () {
        for (int i = 0; i < movies.length; i++) {
          final Map<String, dynamic> movie = movies[i] as Map<String, dynamic>;
          _movies.add(Movie.fromJson(movie));
        }
        _isLoading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .69,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: _movies.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie movie = _movies[index];
                return InkResponse(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<ViewMovieS>(
                        builder: (BuildContext context) => ViewMovieS(
                          movie: movie,
                        ),
                      ),
                    );
                  },
                  child: GridTile(
                    child: Image.network(
                      movie.mediumCoverImage,
                      fit: BoxFit.cover,
                    ),
                    footer: GridTileBar(
                      backgroundColor: Colors.black38,
                      title: Text(movie.title),
                      subtitle: Text(movie.summary),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
