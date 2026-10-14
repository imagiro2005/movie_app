import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/repositories/movies_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movies.dart';

// Mock abstract interface MoviesRepository - chứng minh nguyên lý Dependency Inversion (DIP)
class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  late GetMovies usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetMovies(mockMoviesRepository);
  });

  const tMovies = [
    Movie(
      id: 1,
      title: 'Inception',
      overview: 'A thief steals corporate secrets through dream-sharing technology.',
      posterUrl: 'https://example.com/inception.jpg',
      voteAverage: 8.8,
      releaseDate: '2010',
    ),
    Movie(
      id: 2,
      title: 'Interstellar',
      overview: 'A team of explorers travel through a wormhole in space.',
      posterUrl: 'https://example.com/interstellar.jpg',
      voteAverage: 8.7,
      releaseDate: '2014',
    ),
  ];

  test(
    'nên trả về danh sách phim từ repository khi gọi thành công (không cần mạng)',
    () async {
      // Arrange
      when(() => mockMoviesRepository.getMovies())
          .thenAnswer((_) async => tMovies);

      // Act
      final result = await usecase();

      // Assert
      expect(result, tMovies);
      verify(() => mockMoviesRepository.getMovies()).called(1);
      verifyNoMoreInteractions(mockMoviesRepository);
    },
  );

  test(
    'nên chuyển tiếp Exception từ repository lên phía gọi khi có lỗi',
    () async {
      // Arrange
      when(() => mockMoviesRepository.getMovies())
          .thenThrow(Exception('Lỗi máy chủ HTTP 500'));

      // Act & Assert
      expect(() => usecase(), throwsA(isA<Exception>()));
      verify(() => mockMoviesRepository.getMovies()).called(1);
      verifyNoMoreInteractions(mockMoviesRepository);
    },
  );
}
