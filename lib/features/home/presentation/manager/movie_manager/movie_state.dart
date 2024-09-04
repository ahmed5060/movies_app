import 'package:equatable/equatable.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitialState extends MovieState {}

class GetMoviesLoadingState extends MovieState {}

class GetMoviesErrorState extends MovieState {
  final String errorMessage;

  const GetMoviesErrorState({required this.errorMessage});
}

class GetMoviesSuccessState extends MovieState {
  final AllMoviesModel allMoviesModel;

  const GetMoviesSuccessState({required this.allMoviesModel});
}

class GetMoreMoviesLoadingState extends MovieState {}

class GetMoreMoviesErrorState extends MovieState {
  final String errorMessage;

  const GetMoreMoviesErrorState({required this.errorMessage});
}

class GetMoreMoviesSuccessState extends MovieState {
  final AllMoviesModel allMoviesModel;

  const GetMoreMoviesSuccessState({required this.allMoviesModel});
}