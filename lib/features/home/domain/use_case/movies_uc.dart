import 'package:dartz/dartz.dart';
import 'package:movie/core/Base_Use_Case/Base_Use_Case.dart';
import 'package:movie/core/error/failures.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';
import 'package:movie/features/home/domain/repo/home_base_repo.dart';

class GetMoviesUseCase extends BaseUseCase<AllMoviesModel, String> {
  final HomeBaseRepository homeBaseRepository;

  GetMoviesUseCase({required this.homeBaseRepository});

  @override
  Future<Either<AllMoviesModel, Failure>> call(String parameter) async {
    final result = await homeBaseRepository.getAllMovies(page: parameter);
    return result;
  }
}
