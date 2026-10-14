import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../../features/posts/data/datasources/posts_remote_data_source.dart';
import '../../features/posts/data/repositories/posts_repository_impl.dart';
import '../../features/posts/domain/repositories/posts_repository.dart';
import '../../features/posts/domain/usecases/get_posts.dart';
import '../../features/posts/presentation/bloc/posts_bloc.dart';

final getIt = GetIt.instance;

/// Composition root: concrete implementations are wired here, not in UI widgets.
void configureDependencies() {
  if (getIt.isRegistered<PostsBloc>()) return;

  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<PostsRemoteDataSource>(
    () => PostsRemoteDataSourceImpl(client: getIt<http.Client>()),
  );
  getIt.registerLazySingleton<PostsRepository>(
    () => PostsRepositoryImpl(remoteDataSource: getIt<PostsRemoteDataSource>()),
  );
  getIt.registerLazySingleton(() => GetPosts(getIt<PostsRepository>()));
  getIt.registerFactory(() => PostsBloc(getPosts: getIt<GetPosts>()));
}
