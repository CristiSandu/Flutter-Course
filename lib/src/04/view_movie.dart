import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/src/04/models/movie.dart';

class ViewMovie extends StatelessWidget {
  const ViewMovie({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('SSAPP/04/medium-cover.jpg'),
              fit: BoxFit.cover,
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              final String genre = movie.genres.join('/');
              if (index == 0) {
                return Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                );
              } else if (index == 1) {
                return Text(
                  movie.year.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              } else if (index == 2) {
                return Text(
                  genre.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                );
              } else if (index == 3)
                return Wrap(
                  direction: Axis.horizontal,
                  spacing: 100,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  children: <Widget>[
                    Wrap(
                      children: <Widget>[
                        Image.network(
                          'SSAPP/04/medium-cover.jpg',
                          width: 230,
                          height: 345,
                        )
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      spacing: 32,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.favorite,
                                color: Colors.lightGreen,
                                semanticLabel: 'Likes'),
                            Text(
                              movie.rating.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.timer,
                                color: Colors.lightGreen,
                                semanticLabel: 'RunTime'),
                            Text(
                              movie.runtime.toString() ,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            const Icon(Icons.language,
                                color: Colors.lightGreen,
                                semanticLabel: 'language'),
                            Text(
                              movie.language.toUpperCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                );
              else if (index == 4) {
                return Column(
                  children: <Widget>[
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(movie.summary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Uploaded at: ' + movie.dateUploaded,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                );
              }
              return Text(movie.mediumCoverImage);
            },
          ),
        ),
      ),
    );
  }
}
