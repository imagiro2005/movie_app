import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies/domain/entities/cast.dart';
import 'package:movie_app/features/movies/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_details.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late GetMovieDetails usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetails(mockMovieRepository);
  });

  const tMovieId = 872585;
  const tMovieDetail = MovieDetail(
    id: tMovieId,
    title: 'Oppenheimer',
    overview: 'The story of J. Robert Oppenheimer.',
    posterPath: '/oppenheimer.jpg',
    backdropPath: '/oppenheimer_bg.jpg',
    voteAverage: 8.9,
    releaseDate: '2023-07-21',
    runtime: 180,
    genres: ['Biography', 'Drama', 'History'],
    tagline: 'The world forever changes.',
    cast: [
      Cast(
        id: 1,
        name: 'Cillian Murphy',
        character: 'J. Robert Oppenheimer',
        profilePath: '/cillian.jpg',
      ),
    ],
  );

  test(
    'should get movie details from repository for given id',
    () async {
      // Arrange
      when(() => mockMovieRepository.getMovieDetails(tMovieId))
          .thenAnswer((_) async => const Right(tMovieDetail));

      // Act
      final result = await usecase(const MovieDetailParams(id: tMovieId));

      // Assert
      expect(result, const Right(tMovieDetail));
      verify(() => mockMovieRepository.getMovieDetails(tMovieId)).called(1);
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );

  test(
    'should return NetworkFailure when device has no internet connection',
    () async {
      // Arrange
      const tFailure = NetworkFailure();
      when(() => mockMovieRepository.getMovieDetails(tMovieId))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await usecase(const MovieDetailParams(id: tMovieId));

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockMovieRepository.getMovieDetails(tMovieId)).called(1);
      verifyNoMoreInteractions(mockMovieRepository);
    },
  );
}
