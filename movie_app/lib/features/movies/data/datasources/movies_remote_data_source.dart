import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;

  // Endpoint REST API công khai cung cấp danh sách phim (không cần API Key)
  static const String endpoint =
      'https://raw.githubusercontent.com/vega/vega-datasets/master/data/movies.json';

  const MoviesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await client.get(
        Uri.parse('https://dummyjson.com/products?limit=10'),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> products = data['products'] as List<dynamic>;

        // Map danh sách sản phẩm/phim từ REST API thành MovieModel
        return products.map((item) {
          return MovieModel(
            id: item['id'] as int? ?? 0,
            title: item['title'] as String? ?? 'Untitled Movie',
            overview: item['description'] as String? ?? '',
            posterUrl: (item['thumbnail'] as String?) ??
                'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500',
            voteAverage: (item['rating'] as num?)?.toDouble() ?? 8.5,
            releaseDate: '2024',
          );
        }).toList();
      } else {
        throw Exception('Server error: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Nếu mất mạng hoặc gặp sự cố, ném ngoại lệ để BLoC chuyển sang trạng thái Failure
      throw Exception('Không thể tải dữ liệu từ máy chủ. Vui lòng kiểm tra kết nối mạng! ($e)');
    }
  }
}
