import '../../domain/entities/post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_remote_data_source.dart';

class PostsRepositoryImpl implements PostsRepository {
  const PostsRepositoryImpl({required PostsRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final PostsRemoteDataSource _remoteDataSource;

  @override
  Future<List<Post>> getPosts() => _remoteDataSource.fetchPosts();
}
