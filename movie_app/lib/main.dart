import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/injection.dart';

void main() {
  // 1. Khởi tạo WidgetsFlutterBinding đảm bảo giao tiếp giữa Flutter Engine và Framework
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Cấu hình Dependency Injection (Service Locator get_it)
  configureDependencies();

  // 3. Khởi chạy ứng dụng
  runApp(const App());
}
