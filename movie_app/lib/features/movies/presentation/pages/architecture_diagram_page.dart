import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ArchitectureDiagramPage extends StatelessWidget {
  const ArchitectureDiagramPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture & DI'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeroCard(),
          const SizedBox(height: 20),
          _buildLayerCard(
            title: '1. Presentation Layer (UI & BLoC)',
            color: Colors.blueAccent,
            icon: Icons.layers_outlined,
            description:
                'Chứa Widgets, Pages và State Management (BLoC / Cubit).\n'
                '• Chỉ giao tiếp với tầng Domain thông qua các UseCase (Interactors).\n'
                '• KHÔNG chứa bất kỳ import hoặc logic nào từ Data Layer.',
            components: [
              'TrendingMoviesBloc / NowPlayingMoviesBloc',
              'HomePage, MovieDetailPage, SearchPage',
              'MultiBlocProvider & BlocBuilder',
            ],
          ),
          const SizedBox(height: 16),
          _buildLayerCard(
            title: '2. Domain Layer (Pure Business Logic)',
            color: Colors.greenAccent,
            icon: Icons.hub_outlined,
            description:
                'Trái tim của hệ thống. Hoàn toàn độc lập với Flutter UI, Database hay REST API.\n'
                '• Định nghĩa các Entities (Movie, MovieDetail, Cast).\n'
                '• Định nghĩa Repository Interface (Hợp đồng trừu tượng).\n'
                '• UseCases thực hiện nghiệp vụ chuyên biệt (Single Responsibility).',
            components: [
              'GetTrendingMovies, GetMovieDetails, SearchMovies',
              'MovieRepository (Abstract Contract)',
              'Entities: Movie, MovieDetail, Cast',
            ],
          ),
          const SizedBox(height: 16),
          _buildLayerCard(
            title: '3. Data Layer (Data Sources & Repositories)',
            color: Colors.orangeAccent,
            icon: Icons.storage_outlined,
            description:
                'Chịu trách nhiệm lấy và lưu trữ dữ liệu.\n'
                '• MovieRepositoryImpl thực thi MovieRepository (DIP).\n'
                '• RemoteDataSource giao tiếp qua REST API (Dio client) và parse JSON Model (DTO).\n'
                '• Chuyển đổi Exceptions thành Failures (Either<Failure, T>).',
            components: [
              'MovieRepositoryImpl (Implements Domain Interface)',
              'MovieRemoteDataSource (Dio REST API)',
              'MovieModel, MovieDetailModel (DTO & JSON)',
            ],
          ),
          const SizedBox(height: 20),
          _buildDIPExplanation(),
          const SizedBox(height: 20),
          _buildDIExplanation(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.architecture_rounded, color: AppColors.primary, size: 28),
              SizedBox(width: 10),
              Text(
                'Kiến trúc 3 Lớp Chuẩn',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Quy tắc phụ thuộc (Dependency Rule): Các phụ thuộc của mã nguồn CHỈ ĐƯỢC CHỈ VÀO TRONG (hướng về Domain). '
            'Domain là lõi độc lập, không phụ thuộc vào bất kỳ thư viện hay framework bên ngoài nào.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerCard({
    required String title,
    required Color color,
    required IconData icon,
    required String description,
    required List<String> components,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: AppColors.divider),
          const SizedBox(height: 6),
          const Text(
            'Thành phần chính trong dự án:',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          ...components.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: color, size: 14),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      c,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDIPExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.swap_horizontal_circle_outlined,
                  color: AppColors.accent, size: 22),
              SizedBox(width: 8),
              Text(
                'Nguyên lý đảo ngược phụ thuộc (DIP)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '1. Module cấp cao (Domain/UseCase) không phụ thuộc trực tiếp vào module cấp thấp (REST API/Database). Cả hai đều phụ thuộc vào Abstraction.\n\n'
            '2. Abstraction (MovieRepository) thuộc về tầng Domain. Data layer phụ thuộc ngược lại vào Domain bằng cách implement MovieRepository (Repository Pattern).',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDIExplanation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.precision_manufacturing_outlined,
                  color: Colors.purpleAccent, size: 22),
              SizedBox(width: 8),
              Text(
                'Dependency Injection (get_it + injectable)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '• Service Locator (get_it): Quản lý vòng đời và cung cấp instance của UseCase, Repository, Bloc khi cần.\n\n'
            '• Generator (injectable): Tự động sinh mã đăng ký dependencies tại thời điểm compile, tránh việc cấu hình thủ công dễ gây lỗi.\n\n'
            '• MultiBlocProvider: Tích hợp BLoC vào Widget Tree của Flutter một cách an toàn và dễ tái sử dụng.',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
