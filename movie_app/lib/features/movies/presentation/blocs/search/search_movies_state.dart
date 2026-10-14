import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';

abstract class SearchMoviesState extends Equatable {
  const SearchMoviesState();

  @override
  List<Object?> get props => [];
}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesLoaded extends SearchMoviesState {
  final List<Movie> movies;

  const SearchMoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class SearchMoviesEmpty extends SearchMoviesState {
  final String query;

  const SearchMoviesEmpty(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchMoviesError extends SearchMoviesState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
