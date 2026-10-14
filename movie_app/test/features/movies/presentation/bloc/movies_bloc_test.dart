import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movies.dart';
import 'package:movie_app/features/movies/presentation/bloc/movies_bloc.dart';

// Mock UseCase - chứng minh tầng Presentation không phụ thuộc vào Data Source!
class MockGetMovies extends Mock implements GetMovies {}

void main() {
  late MoviesBloc bloc;
  late MockGetMovies mockGetMovies;

  setUp(() {
    mockGetMovies = MockGetMovies();
    bloc = MoviesBloc(getMovies: mockGetMovies);
  });

  tearDown(() {
    bloc.close();
  });

  const tMovies = [
    Movie(
      id: 1,
      title: 'Oppenheimer',
      overview: 'The story of J. Robert Oppenheimer.',
      posterUrl: 'https://example.com/poster.jpg',
      voteAverage: 8.9,
      releaseDate: '2023',
    ),
  ];

  test('Trạng thái khởi tạo ban đầu phải là MoviesInitial', () {
    expect(bloc.state, equals(const MoviesInitial()));
  });

  blocTest<MoviesBloc, MoviesState>(
    'phát ra [MoviesLoading, MoviesSuccess] khi UseCase trả về dữ liệu thành công',
    build: () {
      when(() => mockGetMovies()).thenAnswer((_) async => tMovies);
      return bloc;
    },
    act: (bloc) => bloc.add(const MoviesRequested()),
    expect: () => [
      const MoviesLoading(),
      const MoviesSuccess(tMovies),
    ],
    verify: (_) {
      verify(() => mockGetMovies()).called(1);
    },
  );

  blocTest<MoviesBloc, MoviesState>(
    'phát ra [MoviesLoading, MoviesFailure] khi UseCase ném Exception',
    build: () {
      when(() => mockGetMovies())
          .thenThrow(Exception('Lỗi mạng hoặc không thể kết nối server'));
      return bloc;
    },
    act: (bloc) => bloc.add(const MoviesRequested()),
    expect: () => [
      const MoviesLoading(),
      const MoviesFailure('Exception: Lỗi mạng hoặc không thể kết nối server'),
    ],
    verify: (_) {
      verify(() => mockGetMovies()).called(1);
    },
  );
}
