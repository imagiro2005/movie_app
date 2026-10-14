import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movies_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;

  const MoviesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getMovies() {
    return remoteDataSource.getMovies();
  }
}
