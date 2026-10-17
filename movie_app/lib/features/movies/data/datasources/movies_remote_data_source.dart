import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;

  // Endpoint REST API thực tế cung cấp danh sách phim chiếu rạp định dạng JSON
  static const String apiUrl =
      'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-in-theaters.json';

  const MoviesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getMovies() async {
    try {
      // Gửi yêu cầu HTTP GET thực tế tới máy chủ REST API
      final response = await client.get(
        Uri.parse(apiUrl),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Lỗi máy chủ: HTTP ${response.statusCode}');
      }
    } catch (e) {
      // Khi mất kết nối hoặc timeout, ném Exception để BLoC chuyển sang trạng thái MoviesFailure
      throw Exception('Không thể tải dữ liệu từ REST API. Vui lòng kiểm tra kết nối mạng! ($e)');
    }
  }
}
