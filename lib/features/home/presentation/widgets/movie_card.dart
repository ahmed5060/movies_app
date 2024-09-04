import 'package:flutter/material.dart';
import 'package:movie/core/utils/config_size.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';
import 'package:movie/features/home/presentation/component/details/details_screen.dart';

class MovieCard extends StatelessWidget {
  final Results results;
  const MovieCard({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(52, 53, 52, 1),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsScreen(results: results)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("https://image.tmdb.org/t/p/w500${results.posterPath}"),
            Padding(
              padding: EdgeInsets.all(ConfigSize.defaultSize!),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber,),
                  SizedBox(
                    width: ConfigSize.defaultSize! - 5,
                  ),
                  Text(
                    "${results.voteAverage}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! - 5),
              child: Text(
                "${results.originalTitle}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: ConfigSize.defaultSize! - 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! - 5),
              child: Text(
                "${results.releaseDate}",
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
