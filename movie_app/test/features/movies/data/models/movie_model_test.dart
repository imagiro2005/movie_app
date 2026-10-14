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
    // Arrange
    final Map<String, dynamic> jsonMap = {
      'id': 1,
      'title': 'Dune: Part Two',
      'overview': 'Paul Atreides unites with Chani.',
      'poster_url': 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500',
      'vote_average': 8.6,
      'release_date': '2024',
    };

    // Act
    final result = MovieModel.fromJson(jsonMap);

    // Assert
    expect(result, tMovieModel);
  });
}
