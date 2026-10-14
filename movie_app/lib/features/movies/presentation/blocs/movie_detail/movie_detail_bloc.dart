import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_movie_details.dart';
import 'movie_detail_event.dart';
import 'movie_detail_state.dart';

@injectable
class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetails getMovieDetails;

  MovieDetailBloc(this.getMovieDetails) : super(MovieDetailInitial()) {
    on<FetchMovieDetailEvent>(_onFetchMovieDetail);
  }

  Future<void> _onFetchMovieDetail(
    FetchMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    final result = await getMovieDetails(MovieDetailParams(id: event.id));
    result.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (detail) => emit(MovieDetailLoaded(detail)),
    );
  }
}
