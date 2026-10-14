import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/search_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'Avatar';
  const tMovieList = [
    Movie(
      id: 19995,
      title: 'Avatar',
      overview: 'A paraplegic Marine dispatched to the moon Pandora.',
      posterPath: '/avatar.jpg',
      backdropPath: '/avatar_bg.jpg',
      voteAverage: 7.9,
      releaseDate: '2009-12-18',
    ),
  ];

  test(
    'should get matching movies from repository for a given query',
    () async {
      // Arrange
      when(() => mockMovieRepository.searchMovies(tQuery))
          .thenAnswer((_) async => const Right(tMovieList));

      // Act
      final result = await usecase(const SearchMoviesParams(query: tQuery));

      // Assert
      expect(result, const Right(tMovieList));
      verify(() => mockMovieRepository.searchMovies(tQuery)).called(1);
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );

  test(
    'should return Failure when search fails',
    () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Search service unavailable');
      when(() => mockMovieRepository.searchMovies(tQuery))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(const SearchMoviesParams(query: tQuery));

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockMovieRepository.searchMovies(tQuery)).called(1);
    },
  );
}
