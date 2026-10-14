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
      title: 'CineStream - Clean Architecture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF12131A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1C24),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1E202B),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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
