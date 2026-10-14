import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import '../../../domain/usecases/get_trending_movies.dart';
import 'trending_movies_event.dart';
import 'trending_movies_state.dart';

@injectable
class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingMoviesBloc(this.getTrendingMovies) : super(TrendingMoviesInitial()) {
    on<FetchTrendingMoviesEvent>(_onFetchTrendingMovies);
  }

  Future<void> _onFetchTrendingMovies(
    FetchTrendingMoviesEvent event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    emit(TrendingMoviesLoading());
    final result = await getTrendingMovies(const NoParams());
    result.fold(
      (failure) => emit(TrendingMoviesError(failure.message)),
      (movies) => emit(TrendingMoviesLoaded(movies)),
    );
  }
}
