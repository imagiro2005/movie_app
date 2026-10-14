import 'package:equatable/equatable.dart';
import 'cast.dart';

class MovieDetail extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final List<String> genres;
  final String? tagline;
  final List<Cast> cast;

  const MovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.genres,
    this.tagline,
    required this.cast,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        releaseDate,
        runtime,
        genres,
        tagline,
        cast,
      ];
}
