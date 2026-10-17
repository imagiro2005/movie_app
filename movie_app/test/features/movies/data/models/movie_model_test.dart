import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

void main() {
  const tMovieModel = MovieModel(
    id: 1,
    title: 'Dune: Part Two',
    overview: 'Paul Atreides unites with Chani.',
    posterUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500',
    voteAverage: 8.6,
    releaseDate: '2024',
  );

  test('MovieModel phải là subclass của Movie entity (Tầng Data kế thừa Domain)', () {
    expect(tMovieModel, isA<Movie>());
  });

  test('nên parse chính xác JSON Map thành MovieModel', () {
    final Map<String, dynamic> jsonMap = {
      'id': 1,
      'title': 'Dune: Part Two',
      'overview': 'Paul Atreides unites with Chani.',
      'poster_url': 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500',
      'vote_average': 8.6,
      'release_date': '2024',
    };

    final result = MovieModel.fromJson(jsonMap);

    expect(result, tMovieModel);
  });

  test('nên parse chính xác dữ liệu trả về từ REST API thực tế (posterurl, storyline, imdbRating)', () {
    final Map<String, dynamic> apiJson = {
      'id': '1',
      'title': 'Black Panther',
      'storyline': 'King T\'Challa returns home to Wakanda.',
      'posterurl': 'https://example.com/bp.jpg',
      'imdbRating': 7.0,
      'releaseDate': '2018-02-14',
    };

    final result = MovieModel.fromJson(apiJson);

    expect(result.id, 1);
    expect(result.title, 'Black Panther');
    expect(result.overview, 'King T\'Challa returns home to Wakanda.');
    expect(result.posterUrl, 'https://example.com/bp.jpg');
    expect(result.voteAverage, 7.0);
    expect(result.releaseDate, '2018');
  });
}
