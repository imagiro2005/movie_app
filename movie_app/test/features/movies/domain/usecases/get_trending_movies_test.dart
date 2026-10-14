import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/get_trending_movies.dart';

// Mock abstract interface MovieRepository - Demonstrating Dependency Inversion
class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetTrendingMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetTrendingMovies(mockMovieRepository);
  });

  const tMovieList = [
    Movie(
      id: 1,
      title: 'Inception',
      overview: 'A thief who steals corporate secrets through dream-sharing tech.',
      posterPath: '/path/to/poster.jpg',
      backdropPath: '/path/to/backdrop.jpg',
      voteAverage: 8.8,
      releaseDate: '2010-07-16',
    ),
    Movie(
      id: 2,
      title: 'Interstellar',
      overview: 'A team of explorers travel through a wormhole in space.',
      posterPath: '/path/to/interstellar.jpg',
      backdropPath: '/path/to/space.jpg',
      voteAverage: 8.7,
      releaseDate: '2014-11-07',
    ),
  ];

  test(
    'should get trending movies from repository when call is successful',
    () async {
      // Arrange
      when(() => mockMovieRepository.getTrendingMovies())
          .thenAnswer((_) async => const Right(tMovieList));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result, const Right(tMovieList));
      verify(() => mockMovieRepository.getTrendingMovies()).called(1);
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );

  test(
    'should return ServerFailure when repository fails to fetch trending movies',
    () async {
      // Arrange
      const tFailure = ServerFailure(message: 'Internal Server Error', statusCode: 500);
      when(() => mockMovieRepository.getTrendingMovies())
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockMovieRepository.getTrendingMovies()).called(1);
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );
}
