import 'package:get_it/get_it.dart';
import 'package:movie/features/home/data/data_source/home_remotly_data_source.dart';
import 'package:movie/features/home/data/repo_imp/home_repo_imp.dart';
import 'package:movie/features/home/domain/repo/home_base_repo.dart';
import 'package:movie/features/home/domain/use_case/movies_uc.dart';
import 'package:movie/features/home/domain/use_case/search_uc.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_bloc.dart';
import 'package:movie/features/home/presentation/manager/search_manager/search_bloc.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc
    getIt.registerLazySingleton(() => MovieBloc(getMoviesUseCase: getIt()));
    getIt.registerLazySingleton(() => SearchBloc(searchUseCase: getIt()));

    //use_case
    getIt.registerFactory(() => GetMoviesUseCase(homeBaseRepository: getIt()));
    getIt.registerFactory(() => SearchUseCase(homeBaseRepository: getIt()));

    //Remote Date
    getIt.registerLazySingleton<HomeBaseRemotelyDataSource>(
        () => HomeRemotelyDataSource());

    //Repository Implementation
    getIt.registerLazySingleton<HomeBaseRepository>(
        () => HomeRepositoryImp(homeBaseRemotelyDataSource: getIt()));

  }
}
