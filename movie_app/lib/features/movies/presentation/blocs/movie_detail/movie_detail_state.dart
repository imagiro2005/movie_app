import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie_detail.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object?> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  const MovieDetailLoaded(this.movieDetail);

  @override
  List<Object?> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
