import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

abstract interface class PostsRemoteDataSource {
  Future<List<PostModel>> fetchPosts();
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  PostsRemoteDataSourceImpl({required http.Client client}) : _client = client;

  final http.Client _client;
  static final Uri _endpoint = Uri.https('jsonplaceholder.typicode.com', '/posts');

  @override
  Future<List<PostModel>> fetchPosts() async {
    final response = await _client.get(_endpoint);
    if (response.statusCode != 200) {
      throw Exception('API request failed with status ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! List) {
      throw const FormatException('Expected a JSON array from posts API.');
    }
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(PostModel.fromJson)
        .toList(growable: false);
  }
}
