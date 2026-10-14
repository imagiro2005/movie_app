import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/core/usecases/usecase.dart';
import '../../../domain/usecases/get_now_playing_movies.dart';
import 'now_playing_movies_event.dart';
import 'now_playing_movies_state.dart';

@injectable
class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc(this.getNowPlayingMovies)
      : super(NowPlayingMoviesInitial()) {
    on<FetchNowPlayingMoviesEvent>(_onFetchNowPlayingMovies);
  }

  Future<void> _onFetchNowPlayingMovies(
    FetchNowPlayingMoviesEvent event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    emit(NowPlayingMoviesLoading());
    final result = await getNowPlayingMovies(const NoParams());
    result.fold(
      (failure) => emit(NowPlayingMoviesError(failure.message)),
      (movies) => emit(NowPlayingMoviesLoaded(movies)),
    );
  }
}
