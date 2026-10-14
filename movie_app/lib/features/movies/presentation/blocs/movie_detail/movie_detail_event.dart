import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovieDetailEvent extends MovieDetailEvent {
  final int id;

  const FetchMovieDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}
