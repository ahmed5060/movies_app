import 'package:flutter/material.dart';
import 'package:movie/core/utils/config_size.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';

class DetailsScreen extends StatelessWidget {
  final Results results;
  const DetailsScreen({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          results.originalTitle??"",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network("https://image.tmdb.org/t/p/w500${results.backdropPath}"),
          SizedBox(
            height: ConfigSize.defaultSize! * 1.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              results.originalTitle??"",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              results.releaseDate??"",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.network(
                  "https://image.tmdb.org/t/p/w500${results.posterPath}",
                  scale: 3.5,
                ),

                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          results.overview??"",
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.star, color: Colors.amber,),
                            SizedBox(
                              width: ConfigSize.defaultSize! - 5,
                            ),
                            Text(
                              results.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ],
      ),
    );
  }
}
