import 'package:equatable/equatable.dart';
import 'package:movie/features/home/data/models/all_movies_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String errorMessage;

  const SearchErrorState({required this.errorMessage});
}

class SearchSuccessState extends SearchState {
  final AllMoviesModel allMoviesModel;

  const SearchSuccessState({required this.allMoviesModel});
}