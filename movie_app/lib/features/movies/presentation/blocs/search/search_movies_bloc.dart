import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/search_movies.dart';
import 'search_movies_event.dart';
import 'search_movies_state.dart';

@injectable
class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc(this.searchMovies) : super(SearchMoviesInitial()) {
    on<QueryChangedEvent>(_onQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onQueryChanged(
    QueryChangedEvent event,
    Emitter<SearchMoviesState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      emit(SearchMoviesInitial());
      return;
    }

    emit(SearchMoviesLoading());
    final result = await searchMovies(SearchMoviesParams(query: query));
    result.fold(
      (failure) => emit(SearchMoviesError(failure.message)),
      (movies) {
        if (movies.isEmpty) {
          emit(SearchMoviesEmpty(query));
        } else {
          emit(SearchMoviesLoaded(movies));
        }
      },
    );
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchMoviesState> emit,
  ) {
    emit(SearchMoviesInitial());
  }
}
