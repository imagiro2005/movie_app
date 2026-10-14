// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_app/core/di/injection.dart' as _i161;
import 'package:movie_app/features/movies/data/datasources/movie_remote_data_source.dart'
    as _i406;
import 'package:movie_app/features/movies/data/repositories/movie_repository_impl.dart'
    as _i1041;
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart'
    as _i512;
import 'package:movie_app/features/movies/domain/usecases/get_movie_details.dart'
    as _i407;
import 'package:movie_app/features/movies/domain/usecases/get_now_playing_movies.dart'
    as _i610;
import 'package:movie_app/features/movies/domain/usecases/get_top_rated_movies.dart'
    as _i0;
import 'package:movie_app/features/movies/domain/usecases/get_trending_movies.dart'
    as _i67;
import 'package:movie_app/features/movies/domain/usecases/search_movies.dart'
    as _i1012;
import 'package:movie_app/features/movies/presentation/blocs/movie_detail/movie_detail_bloc.dart'
    as _i283;
import 'package:movie_app/features/movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart'
    as _i320;
import 'package:movie_app/features/movies/presentation/blocs/search/search_movies_bloc.dart'
    as _i622;
import 'package:movie_app/features/movies/presentation/blocs/trending/trending_movies_bloc.dart'
    as _i771;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i406.MovieRemoteDataSource>(
      () => _i406.MovieRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i512.MovieRepository>(
      () => _i1041.MovieRepositoryImpl(
        remoteDataSource: gh<_i406.MovieRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i407.GetMovieDetails>(
      () => _i407.GetMovieDetails(gh<_i512.MovieRepository>()),
    );
    gh.lazySingleton<_i610.GetNowPlayingMovies>(
      () => _i610.GetNowPlayingMovies(gh<_i512.MovieRepository>()),
    );
    gh.lazySingleton<_i0.GetTopRatedMovies>(
      () => _i0.GetTopRatedMovies(gh<_i512.MovieRepository>()),
    );
    gh.lazySingleton<_i67.GetTrendingMovies>(
      () => _i67.GetTrendingMovies(gh<_i512.MovieRepository>()),
    );
    gh.lazySingleton<_i1012.SearchMovies>(
      () => _i1012.SearchMovies(gh<_i512.MovieRepository>()),
    );
    gh.factory<_i283.MovieDetailBloc>(
      () => _i283.MovieDetailBloc(gh<_i407.GetMovieDetails>()),
    );
    gh.factory<_i320.NowPlayingMoviesBloc>(
      () => _i320.NowPlayingMoviesBloc(gh<_i610.GetNowPlayingMovies>()),
    );
    gh.factory<_i771.TrendingMoviesBloc>(
      () => _i771.TrendingMoviesBloc(gh<_i67.GetTrendingMovies>()),
    );
    gh.factory<_i622.SearchMoviesBloc>(
      () => _i622.SearchMoviesBloc(gh<_i1012.SearchMovies>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i161.RegisterModule {}
