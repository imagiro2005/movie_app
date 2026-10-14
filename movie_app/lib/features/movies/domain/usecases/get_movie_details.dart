import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

@lazySingleton
class GetMovieDetails implements UseCase<MovieDetail, MovieDetailParams> {
  final MovieRepository repository;

  GetMovieDetails(this.repository);

  @override
  Future<Either<Failure, MovieDetail>> call(MovieDetailParams params) async {
    return await repository.getMovieDetails(params.id);
  }
}

class MovieDetailParams extends Equatable {
  final int id;

  const MovieDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
