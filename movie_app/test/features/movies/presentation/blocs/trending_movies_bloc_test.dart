import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/features/movies/presentation/blocs/trending/trending_movies_bloc.dart';
import 'package:movie_app/features/movies/presentation/blocs/trending/trending_movies_event.dart';
import 'package:movie_app/features/movies/presentation/blocs/trending/trending_movies_state.dart';

// Mock the UseCase - proving Presentation layer does NOT depend on Data Source!
class MockGetTrendingMovies extends Mock implements GetTrendingMovies {}

void main() {
  late TrendingMoviesBloc bloc;
  late MockGetTrendingMovies mockGetTrendingMovies;

  setUp(() {
    mockGetTrendingMovies = MockGetTrendingMovies();
    bloc = TrendingMoviesBloc(mockGetTrendingMovies);
  });

  tearDown(() {
    bloc.close();
  });

  const tMovies = [
    Movie(
      id: 1,
      title: 'Interstellar',
      overview: 'Mankind was born on Earth. It was never meant to die here.',
      posterPath: '/poster.jpg',
      backdropPath: '/bg.jpg',
      voteAverage: 8.7,
      releaseDate: '2014-11-07',
    ),
  ];

  test('initial state should be TrendingMoviesInitial', () {
    expect(bloc.state, equals(TrendingMoviesInitial()));
  });

  blocTest<TrendingMoviesBloc, TrendingMoviesState>(
    'should emit [TrendingMoviesLoading, TrendingMoviesLoaded] when data is gotten successfully from UseCase',
    build: () {
      when(() => mockGetTrendingMovies(const NoParams()))
          .thenAnswer((_) async => const Right(tMovies));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTrendingMoviesEvent()),
    expect: () => [
      TrendingMoviesLoading(),
      const TrendingMoviesLoaded(tMovies),
    ],
    verify: (_) {
      verify(() => mockGetTrendingMovies(const NoParams())).called(1);
    },
  );

  blocTest<TrendingMoviesBloc, TrendingMoviesState>(
    'should emit [TrendingMoviesLoading, TrendingMoviesError] when getting data from UseCase fails',
    build: () {
      when(() => mockGetTrendingMovies(const NoParams())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'Server failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchTrendingMoviesEvent()),
    expect: () => [
      TrendingMoviesLoading(),
      const TrendingMoviesError('Server failure'),
    ],
    verify: (_) {
      verify(() => mockGetTrendingMovies(const NoParams())).called(1);
    },
  );
}
