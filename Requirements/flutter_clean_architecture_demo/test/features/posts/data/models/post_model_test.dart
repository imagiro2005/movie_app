import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_demo/features/posts/data/models/post_model.dart';

void main() {
  test('parses JSON into a post model', () {
    final model = PostModel.fromJson({
      'id': 7,
      'title': 'Example title',
      'body': 'Example body',
    });

    expect(model.id, 7);
    expect(model.title, 'Example title');
    expect(model.body, 'Example body');
  });
}
