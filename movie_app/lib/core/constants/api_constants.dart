import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseUrl =>
      dotenv.env['TMDB_BASE_URL'] ?? 'https://api.themoviedb.org/3';

  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';

  static String get imageBaseUrl =>
      dotenv.env['TMDB_IMAGE_BASE_URL'] ?? 'https://image.tmdb.org/t/p';

  static String imageUrl(String? path, {String size = 'w500'}) {
    if (path == null || path.isEmpty) {
      return 'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500';
    }
    if (path.startsWith('http')) {
      return path;
    }
    return '$imageBaseUrl/$size$path';
  }

  // Endpoints
  static const String trendingMovies = '/trending/movie/day';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String topRatedMovies = '/movie/top_rated';
  static const String movieDetails = '/movie';
  static const String searchMovies = '/search/movie';
}
