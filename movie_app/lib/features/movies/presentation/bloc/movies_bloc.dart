import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movies.dart';

// EVENTS
abstract class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

class MoviesRequested extends MoviesEvent {
  const MoviesRequested();
}

// STATES
abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {
  const MoviesInitial();
}

class MoviesLoading extends MoviesState {
  const MoviesLoading();
}

class MoviesSuccess extends MoviesState {
  final List<Movie> movies;

  const MoviesSuccess(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MoviesFailure extends MoviesState {
  final String message;

  const MoviesFailure(this.message);

  @override
  List<Object?> get props => [message];
}

// BLOC
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMovies getMovies;

  MoviesBloc({required this.getMovies}) : super(const MoviesInitial()) {
    on<MoviesRequested>(_onMoviesRequested);
  }

  Future<void> _onMoviesRequested(
    MoviesRequested event,
    Emitter<MoviesState> emit,
  ) async {
    emit(const MoviesLoading());
    try {
      final movies = await getMovies();
      emit(MoviesSuccess(movies));
    } catch (e) {
      emit(MoviesFailure(e.toString()));
    }
  }
}
