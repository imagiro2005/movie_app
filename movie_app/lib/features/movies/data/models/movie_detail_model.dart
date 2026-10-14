import '../../domain/entities/movie_detail.dart';
import 'cast_model.dart';

class MovieDetailModel extends MovieDetail {
  const MovieDetailModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.releaseDate,
    required super.runtime,
    required super.genres,
    super.tagline,
    required super.cast,
  });

  factory MovieDetailModel.fromJson(
    Map<String, dynamic> json, {
    List<CastModel> cast = const [],
  }) {
    final genresList = (json['genres'] as List<dynamic>?)
            ?.map((g) => (g as Map<String, dynamic>)['name'] as String? ?? '')
            .where((name) => name.isNotEmpty)
            .toList() ??
        [];

    return MovieDetailModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] as String? ?? '',
      runtime: json['runtime'] as int? ?? 0,
      genres: genresList,
      tagline: json['tagline'] as String?,
      cast: cast,
    );
  }
}
