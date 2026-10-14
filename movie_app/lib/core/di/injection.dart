import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../features/movies/data/datasources/movies_remote_data_source.dart';
import '../../features/movies/data/repositories/movies_repository_impl.dart';
import '../../features/movies/domain/repositories/movies_repository.dart';
import '../../features/movies/domain/usecases/get_movies.dart';
import '../../features/movies/presentation/bloc/movies_bloc.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // 1. External dependencies (HTTP Client)
  getIt.registerLazySingleton<http.Client>(() => http.Client());

  // 2. Data Layer (Data Source & Repository Implementation)
  getIt.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(client: getIt()),
  );
  getIt.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(remoteDataSource: getIt()),
  );

  // 3. Domain Layer (UseCases)
  getIt.registerLazySingleton<GetMovies>(
    () => GetMovies(getIt()),
  );

  // 4. Presentation Layer (BLoC)
  getIt.registerFactory<MoviesBloc>(
    () => MoviesBloc(getMovies: getIt()),
  );
}
