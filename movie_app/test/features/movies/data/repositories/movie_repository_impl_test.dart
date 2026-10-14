import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/data/repositories/movie_repository_impl.dart';

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

void main() {
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tMovieModelList = [
    MovieModel(
      id: 1,
      title: 'Dune: Part Two',
      overview: 'Paul Atreides unites with Chani.',
      posterPath: '/dune.jpg',
      backdropPath: '/dune_bg.jpg',
      voteAverage: 8.6,
      releaseDate: '2024-03-01',
    ),
  ];

  group('getTrendingMovies', () {
    test(
      'should return remote data when call to remote data source is successful',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.getTrendingMovies())
            .thenAnswer((_) async => tMovieModelList);

        // Act
        final result = await repository.getTrendingMovies();

        // Assert
        expect(result, const Right(tMovieModelList));
        verify(() => mockRemoteDataSource.getTrendingMovies()).called(1);
      },
    );

    test(
      'should return ServerFailure when call to remote data source throws ServerException',
      () async {
        // Arrange
        when(() => mockRemoteDataSource.getTrendingMovies())
            .thenThrow(const ServerException(message: 'Server Error', statusCode: 500));

        // Act
        final result = await repository.getTrendingMovies();

        // Assert
        expect(result, const Left(ServerFailure(message: 'Server Error', statusCode: 500)));
        verify(() => mockRemoteDataSource.getTrendingMovies()).called(1);
      },
    );
  });
}
