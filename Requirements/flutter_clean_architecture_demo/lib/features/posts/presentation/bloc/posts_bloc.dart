import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';

sealed class PostsState extends Equatable {
  const PostsState();
  @override
  List<Object?> get props => [];
}

final class PostsInitial extends PostsState {
  const PostsInitial();
}
final class PostsLoading extends PostsState {
  const PostsLoading();
}
final class PostsLoaded extends PostsState {
  const PostsLoaded(this.posts);
  final List<Post> posts;
  @override
  List<Object?> get props => [posts];
}
final class PostsFailure extends PostsState {
  const PostsFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

sealed class PostsEvent {
  const PostsEvent();
}
final class PostsRequested extends PostsEvent {
  const PostsRequested();
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc({required GetPosts getPosts})
      : _getPosts = getPosts,
        super(const PostsInitial()) {
    on<PostsRequested>((event, emit) async {
      emit(const PostsLoading());
      try {
        final posts = await _getPosts();
        emit(PostsLoaded(posts));
      } catch (_) {
        emit(const PostsFailure('Không thể tải dữ liệu. Vui lòng thử lại.'));
      }
    });
  }

  final GetPosts _getPosts;
}
