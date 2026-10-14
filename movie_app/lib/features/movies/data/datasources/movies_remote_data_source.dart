import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final http.Client client;

  const MoviesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getMovies() async {
    // Giả lập độ trễ mạng như gọi REST API thực tế (600ms)
    await Future.delayed(const Duration(milliseconds: 600));

    // Dữ liệu Resource JSON giả lập chuẩn về phim ảnh (Mock Movies Resource)
    final List<Map<String, dynamic>> mockMoviesJson = [
      {
        'id': 1,
        'title': 'Oppenheimer',
        'year': '2023',
        'rating': 8.9,
        'overview':
            'Câu chuyện về nhà vật lý lý thuyết J. Robert Oppenheimer, người đứng đầu Dự án Manhattan nghiên cứu và chế tạo bom nguyên tử đầu tiên trong Thế chiến II.',
        'poster_url':
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=500',
      },
      {
        'id': 2,
        'title': 'Dune: Part Two',
        'year': '2024',
        'rating': 8.6,
        'overview':
            'Paul Atreides hợp lực cùng Chani và người Fremen để trả thù những kẻ đã hủy hoại gia đình mình, đồng thời đối mặt với số phận vũ trụ.',
        'poster_url':
            'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500',
      },
      {
        'id': 3,
        'title': 'Interstellar',
        'year': '2014',
        'rating': 8.7,
        'overview':
            'Một nhóm nhà thám hiểm du hành qua hố sâu không gian để tìm kiếm hành tinh mới có thể duy trì sự sống cho nhân loại khi Trái Đất cạn kiệt tài nguyên.',
        'poster_url':
            'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500',
      },
      {
        'id': 4,
        'title': 'The Dark Knight',
        'year': '2008',
        'rating': 9.0,
        'overview':
            'Batman cùng thanh tra James Gordon và luật sư Harvey Dent đối đầu với tên tội phạm tâm thần Joker, kẻ gieo rắc sự hỗn loạn và vô chính phủ tại thành phố Gotham.',
        'poster_url':
            'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=500',
      },
      {
        'id': 5,
        'title': 'Inception',
        'year': '2010',
        'rating': 8.8,
        'overview':
            'Một kẻ đánh cắp thông tin bí mật thương mại bằng cách thâm nhập vào tiềm thức của mục tiêu thông qua công nghệ chia sẻ giấc mơ.',
        'poster_url':
            'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=500',
      },
      {
        'id': 6,
        'title': 'Spider-Man: Across the Spider-Verse',
        'year': '2023',
        'rating': 8.7,
        'overview':
            'Miles Morales bước vào đa vũ trụ và đụng độ một đội ngũ Người Nhện mang trách nhiệm bảo vệ sự tồn vong của các chiều không gian.',
        'poster_url':
            'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=500',
      },
      {
        'id': 7,
        'title': 'Top Gun: Maverick',
        'year': '2022',
        'rating': 8.3,
        'overview':
            'Sau hơn 30 năm cống hiến, phi công siêu đẳng Pete "Maverick" Mitchell trở lại huấn luyện một phi đội trẻ cho nhiệm vụ tối mật bất khả thi.',
        'poster_url':
            'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=500',
      },
      {
        'id': 8,
        'title': 'Avatar: The Way of Water',
        'year': '2022',
        'rating': 7.6,
        'overview':
            'Jake Sully cùng Neytiri và các con phải rời bỏ quê hương để tìm đến vùng đất của người Metkayina ven biển nhằm bảo vệ bộ tộc khỏi sự săn lùng của con người.',
        'poster_url':
            'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=500',
      },
    ];

    // Chuyển đổi JSON Map thành danh sách MovieModel thông qua hàm fromJson
    return mockMoviesJson
        .map((json) => MovieModel.fromJson(json))
        .toList();
  }
}
