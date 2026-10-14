import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movies_bloc.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CineStream — Clean Architecture'),
        actions: [
          IconButton(
            tooltip: 'Làm mới dữ liệu',
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<MoviesBloc>().add(const MoviesRequested());
            },
          ),
          IconButton(
            tooltip: 'Giải thích Kiến trúc',
            icon: const Icon(Icons.info_outline, color: Colors.amber),
            onPressed: () => _showArchitectureDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Đang nạp dữ liệu từ REST API qua Clean Architecture...'),
                ],
              ),
            );
          } else if (state is MoviesSuccess) {
            if (state.movies.isEmpty) {
              return const Center(child: Text('Không có dữ liệu'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<MoviesBloc>().add(const MoviesRequested());
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: state.movies.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              movie.posterUrl,
                              width: 80,
                              height: 110,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 80,
                                height: 110,
                                color: Colors.grey.shade800,
                                child: const Icon(Icons.movie, size: 36),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.voteAverage.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      movie.releaseDate,
                                      style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.overview,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 13,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is MoviesFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off, size: 64, color: Colors.redAccent),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<MoviesBloc>().add(const MoviesRequested());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showArchitectureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.layers, color: Colors.amber),
            SizedBox(width: 8),
            Text('Kiến trúc 3 Lớp & DIP'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '1. Presentation Layer:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightBlueAccent),
              ),
              Text('• MoviesPage & MoviesBloc.\n• Chỉ gửi Event và nhận State từ UseCase.'),
              SizedBox(height: 10),
              Text(
                '2. Domain Layer (Pure Dart):',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.lightGreenAccent),
              ),
              Text('• Movie (Entity), GetMovies (UseCase).\n• MoviesRepository (Interface trừu tượng).\n• Không phụ thuộc vào bất kỳ thư viện bên ngoài nào.'),
              SizedBox(height: 10),
              Text(
                '3. Data Layer:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orangeAccent),
              ),
              Text('• MovieModel (JSON DTO), MoviesRemoteDataSource (HTTP).\n• MoviesRepositoryImpl thực thi interface của Domain (Nguyên lý DIP).'),
              SizedBox(height: 10),
              Text(
                '4. Dependency Injection:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purpleAccent),
              ),
              Text('• get_it quản lý việc khởi tạo và tiêm phụ thuộc trong injection.dart.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
