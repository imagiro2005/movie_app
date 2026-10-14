import 'package:equatable/equatable.dart';

abstract class TrendingMoviesEvent extends Equatable {
  const TrendingMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrendingMoviesEvent extends TrendingMoviesEvent {
  const FetchTrendingMoviesEvent();
}
