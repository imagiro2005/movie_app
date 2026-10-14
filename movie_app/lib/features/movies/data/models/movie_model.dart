import '../../domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    required super.posterUrl,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    // Xử lý linh hoạt cho nhiều nguồn API (TMDB, JSONPlaceholder, Mock API)
    final poster = json['poster_url'] as String? ??
        (json['poster_path'] != null
            ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
            : null) ??
        'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500';

    return MovieModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? json['name'] as String? ?? 'Untitled',
      overview: json['overview'] as String? ?? json['body'] as String? ?? '',
      posterUrl: poster,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ??
          (json['rating'] as num?)?.toDouble() ??
          8.5,
      releaseDate: json['release_date'] as String? ??
          (json['year'] != null ? json['year'].toString() : '2024'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_url': posterUrl,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }
}
