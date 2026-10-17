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
    final poster = json['posterurl'] as String? ??
        json['poster_url'] as String? ??
        (json['poster_path'] != null
            ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
            : null) ??
        'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500';

    final rawRating = json['imdbRating'] ?? json['vote_average'] ?? json['rating'];
    final rating = (rawRating is num)
        ? rawRating.toDouble()
        : double.tryParse(rawRating?.toString() ?? '') ?? 8.0;

    final rawDate = json['releaseDate'] ?? json['release_date'] ?? json['year'];
    final dateStr = rawDate?.toString() ?? '2024';

    return MovieModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] as String? ?? json['name'] as String? ?? 'Untitled',
      overview: json['storyline'] as String? ??
          json['overview'] as String? ??
          json['body'] as String? ??
          '',
      posterUrl: poster,
      voteAverage: rating,
      releaseDate: dateStr.length >= 4 ? dateStr.substring(0, 4) : dateStr,
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
