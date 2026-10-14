import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class GetMovies {
  final MoviesRepository repository;

  const GetMovies(this.repository);

  Future<List<Movie>> call() {
    return repository.getMovies();
  }
}
