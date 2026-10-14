import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'features/movies/presentation/bloc/movies_bloc.dart';
import 'features/movies/presentation/pages/movies_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhePhim — Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Nền sáng thanh lịch
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE50914), // Màu đỏ thương hiệu PhePhim
          brightness: Brightness.light,
          primary: const Color(0xFFE50914),
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1A202C),
          elevation: 0.5,
          shadowColor: Colors.black12,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1.5,
          shadowColor: Colors.black.withValues(alpha: 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFEDF2F7), width: 1),
          ),
        ),
      ),
      home: BlocProvider(
        create: (_) => getIt<MoviesBloc>()..add(const MoviesRequested()),
        child: const MoviesPage(),
      ),
    );
  }
}
