import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'features/movies/presentation/blocs/now_playing/now_playing_movies_event.dart';
import 'features/movies/presentation/blocs/trending/trending_movies_bloc.dart';
import 'features/movies/presentation/blocs/trending/trending_movies_event.dart';
import 'features/movies/presentation/pages/home_page.dart';

void main() async {
  // 1. Khởi tạo WidgetsBinding đảm bảo giao tiếp giữa Flutter Framework và Engine
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Tải biến môi trường từ file .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint('Note: .env file not loaded or missing. Using default configs.');
  }

  // 3. Khởi tạo Service Locator & Dependency Injection (get_it + injectable)
  await configureDependencies();

  // 4. Khởi chạy ứng dụng với MultiBlocProvider
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TrendingMoviesBloc>(
          create: (_) =>
              getIt<TrendingMoviesBloc>()..add(const FetchTrendingMoviesEvent()),
        ),
        BlocProvider<NowPlayingMoviesBloc>(
          create: (_) => getIt<NowPlayingMoviesBloc>()
            ..add(const FetchNowPlayingMoviesEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'CineStream - Clean Architecture',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
