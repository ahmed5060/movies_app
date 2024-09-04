import 'package:dartz/dartz.dart';
import 'package:movie/core/error/failures.dart';
import 'package:movie/core/utils/api_helper/dio_helper.dart';
import 'package:movie/features/home/data/data_source/home_remotly_data_source.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';
import 'package:movie/features/home/domain/repo/home_base_repo.dart';


class HomeRepositoryImp extends HomeBaseRepository {
  final HomeBaseRemotelyDataSource homeBaseRemotelyDataSource;

  HomeRepositoryImp({required this.homeBaseRemotelyDataSource});

  @override
  Future<Either<AllMoviesModel, Failure>> getAllMovies({required String page}) async {
    try {
      final result = await homeBaseRemotelyDataSource.getAllMovies(page: page);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<AllMoviesModel, Failure>> search({required String query}) async {
    try {
      final result = await homeBaseRemotelyDataSource.search(query: query);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
