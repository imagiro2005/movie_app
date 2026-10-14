import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class GetPosts {
  const GetPosts(this.repository);

  final PostsRepository repository;

  Future<List<Post>> call() => repository.getPosts();
}
