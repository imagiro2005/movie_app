import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3157D5)),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => getIt<PostsBloc>()..add(const PostsRequested()),
        child: const PostsPage(),
      ),
    );
  }
}
