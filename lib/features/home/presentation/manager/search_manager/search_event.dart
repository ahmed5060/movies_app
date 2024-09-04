import 'package:equatable/equatable.dart';

abstract class SearchEventBase extends Equatable {
  const SearchEventBase();

  @override
  List<Object> get props => [];
}

class SearchEvent extends SearchEventBase {
  final String query;
  const SearchEvent({required this.query});
}