import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_clean_architecture_demo/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_demo/features/posts/domain/repositories/posts_repository.dart';
import 'package:flutter_clean_architecture_demo/features/posts/domain/usecases/get_posts.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late MockPostsRepository repository;
  late GetPosts useCase;

  setUp(() {
    repository = MockPostsRepository();
    useCase = GetPosts(repository);
  });

  test('returns posts provided by the repository', () async {
    const expected = [
      Post(id: 1, title: 'Hello', body: 'World'),
      Post(id: 2, title: 'Clean Architecture', body: 'Use abstractions'),
    ];
    when(() => repository.getPosts()).thenAnswer((_) async => expected);

    final result = await useCase();

    expect(result, expected);
    verify(() => repository.getPosts()).called(1);
  });

  test('propagates repository errors to the caller', () async {
    when(() => repository.getPosts()).thenThrow(Exception('offline'));

    expect(() => useCase(), throwsA(isA<Exception>()));
  });
}
