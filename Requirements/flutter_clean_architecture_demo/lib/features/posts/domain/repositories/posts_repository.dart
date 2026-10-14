import '../entities/post.dart';

/// Domain contract. Domain depends on an abstraction, never on HTTP or JSON.
abstract interface class PostsRepository {
  Future<List<Post>> getPosts();
}
