import 'package:equatable/equatable.dart';

abstract class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object?> get props => [];
}

class QueryChangedEvent extends SearchMoviesEvent {
  final String query;

  const QueryChangedEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearchEvent extends SearchMoviesEvent {
  const ClearSearchEvent();
}
