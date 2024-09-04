import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/utils/api_helper/dio_helper.dart';
import 'package:movie/features/home/domain/use_case/movies_uc.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_event.dart';
import 'package:movie/features/home/presentation/manager/movie_manager/movie_state.dart';

class MovieBloc extends Bloc<MoviesEventBase, MovieState> {
  final GetMoviesUseCase getMoviesUseCase;
  MovieBloc({required this.getMoviesUseCase})
      : super(MovieInitialState()) {
    on<GetMoviesEvent>((event, emit) async {
      emit(GetMoviesLoadingState());
      final result = await getMoviesUseCase.call(event.page);
      result.fold(
              (l) => emit(GetMoviesSuccessState(allMoviesModel: l)),
              (r) => emit(GetMoviesErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

    on<GetMoreMoviesEvent>((event, emit) async {
      emit(GetMoreMoviesLoadingState());
      final result = await getMoviesUseCase.call(event.page);
      result.fold(
              (l) => emit(GetMoreMoviesSuccessState(allMoviesModel: l)),
              (r) => emit(GetMoreMoviesErrorState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
