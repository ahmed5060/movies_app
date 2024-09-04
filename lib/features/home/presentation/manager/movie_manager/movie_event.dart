import 'package:equatable/equatable.dart';

abstract class MoviesEventBase extends Equatable {
  const MoviesEventBase();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MoviesEventBase {
  final String page;
  const GetMoviesEvent({required this.page});
}

class GetMoreMoviesEvent extends MoviesEventBase {
  final String page;
  const GetMoreMoviesEvent({required this.page});
}