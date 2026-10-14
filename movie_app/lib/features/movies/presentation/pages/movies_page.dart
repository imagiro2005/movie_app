import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movies_bloc.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFE50914),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE50914).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.movie_creation, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'PhePhim',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 19,
                    letterSpacing: -0.5,
                    color: Color(0xFF1A202C),
                  ),
                ),
                Text(
                  'Clean Architecture & Dependency Injection',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF718096),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Làm mới dữ liệu',
            icon: const Icon(Icons.refresh, color: Color(0xFF4A5568)),
            onPressed: () {
              context.read<MoviesBloc>().add(const MoviesRequested());
            },
          ),
          IconButton(
            tooltip: 'Giải thích Kiến trúc',
            icon: const Icon(Icons.info_outline_rounded, color: Color(0xFFE50914)),
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
                  CircularProgressIndicator(
                    color: Color(0xFFE50914),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Đang nạp dữ liệu phim từ REST API...',
                    style: TextStyle(
                      color: Color(0xFF718096),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is MoviesSuccess) {
            if (state.movies.isEmpty) {
              return const Center(
                child: Text(
                  'Không có dữ liệu',
                  style: TextStyle(color: Color(0xFF718096)),
                ),
              );
            }
            return RefreshIndicator(
              color: const Color(0xFFE50914),
              onRefresh: () async {
                context.read<MoviesBloc>().add(const MoviesRequested());
              },
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                itemCount: state.movies.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              movie.posterUrl,
                              width: 90,
                              height: 125,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 90,
                                height: 125,
                                color: const Color(0xFFEDF2F7),
                                child: const Icon(
                                  Icons.movie_outlined,
                                  size: 40,
                                  color: Color(0xFFA0AEC0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                    color: Color(0xFF1A202C),
                                    letterSpacing: -0.3,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF9E6),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: const Color(0xFFFFD166),
                                          width: 0.8,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            size: 15,
                                            color: Color(0xFFF59E0B),
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            movie.voteAverage.toStringAsFixed(1),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Color(0xFFB45309),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEDF2F7),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        movie.releaseDate,
                                        style: const TextStyle(
                                          color: Color(0xFF4A5568),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.overview,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color(0xFF4A5568),
                                    fontSize: 13,
                                    height: 1.4,
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
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.cloud_off_rounded,
                        size: 48,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A5568),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE50914),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        context.read<MoviesBloc>().add(const MoviesRequested());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text(
                        'Thử lại',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const Row(
          children: [
            Icon(Icons.layers_rounded, color: Color(0xFFE50914)),
            SizedBox(width: 10),
            Text(
              'Kiến trúc 3 Lớp & DIP',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF1A202C),
              ),
            ),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '1. Presentation Layer (UI & BLoC):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2563EB),
                ),
              ),
              Text(
                '• MoviesPage & MoviesBloc.\n• Chỉ gửi Event và nhận State từ UseCase, không import Data Source.',
                style: TextStyle(fontSize: 13, color: Color(0xFF4A5568), height: 1.4),
              ),
              SizedBox(height: 12),
              Text(
                '2. Domain Layer (Pure Dart):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF16A34A),
                ),
              ),
              Text(
                '• Movie (Entity), GetMovies (UseCase).\n• MoviesRepository (Interface trừu tượng).\n• Độc lập hoàn toàn với Flutter UI và nguồn dữ liệu.',
                style: TextStyle(fontSize: 13, color: Color(0xFF4A5568), height: 1.4),
              ),
              SizedBox(height: 12),
              Text(
                '3. Data Layer (DIP & REST API):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFEA580C),
                ),
              ),
              Text(
                '• MovieModel (JSON DTO), MoviesRemoteDataSource.\n• MoviesRepositoryImpl thực thi interface của Domain.',
                style: TextStyle(fontSize: 13, color: Color(0xFF4A5568), height: 1.4),
              ),
              SizedBox(height: 12),
              Text(
                '4. Dependency Injection (DI):',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9333EA),
                ),
              ),
              Text(
                '• Service Locator get_it đăng ký dependencies tại Composition Root (lib/core/di/injection.dart).',
                style: TextStyle(fontSize: 13, color: Color(0xFF4A5568), height: 1.4),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Đã hiểu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFE50914),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
