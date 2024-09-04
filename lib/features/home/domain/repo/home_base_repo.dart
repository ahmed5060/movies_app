import 'package:dartz/dartz.dart';
import 'package:movie/core/error/failures.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';

abstract class HomeBaseRepository {
  Future<Either<AllMoviesModel, Failure>> getAllMovies({required String page});
  Future<Either<AllMoviesModel, Failure>> search({required String query});

}
