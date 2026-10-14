# Flutter Clean Architecture Demo

Ứng dụng mẫu Flutter đọc danh sách bài viết từ REST API `https://jsonplaceholder.typicode.com/posts`, minh họa Clean Architecture, Repository Pattern, UseCase, Dependency Inversion và Dependency Injection với `get_it`. Presentation sử dụng BLoC.

## Yêu cầu

- Flutter SDK tương thích Dart `>=3.3.0 <4.0.0`
- Android Studio/Android SDK hoặc Chrome (nếu chạy web)
- Kết nối Internet để gọi API

## Chạy ứng dụng

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Để chạy trên Chrome: `flutter run -d chrome`. Kiểm tra thiết bị với `flutter devices`.

## Cấu trúc

```text
lib/
  main.dart
  app.dart
  core/di/injection.dart
  features/posts/
    domain/
      entities/post.dart
      repositories/posts_repository.dart
      usecases/get_posts.dart
    data/
      models/post_model.dart
      datasources/posts_remote_data_source.dart
      repositories/posts_repository_impl.dart
    presentation/
      bloc/posts_bloc.dart
      pages/posts_page.dart
test/
  features/posts/domain/usecases/get_posts_test.dart
  features/posts/data/models/post_model_test.dart
```

## Luồng dữ liệu

1. `PostsPage` gửi `PostsRequested` tới `PostsBloc`.
2. `PostsBloc` gọi `GetPosts` (UseCase).
3. `GetPosts` chỉ biết abstraction `PostsRepository` thuộc Domain.
4. `PostsRepositoryImpl` ở Data thực thi hợp đồng, gọi `PostsRemoteDataSource`.
5. Data Source dùng `http.Client`, giải mã JSON thành `PostModel`.
6. Kết quả trả ngược qua Repository → UseCase → BLoC → UI.

## Clean Architecture & DIP

- **Presentation**: widget và BLoC; không import Data Source hoặc HTTP client.
- **Domain**: entity, repository abstraction, use case; không phụ thuộc Flutter UI, HTTP, JSON hoặc GetIt.
- **Data**: model, remote data source và repository implementation.
- **DIP**: tầng cấp cao (UseCase) phụ thuộc abstraction `PostsRepository`, không phụ thuộc implementation cụ thể.
- **Repository Pattern**: cô lập nguồn dữ liệu khỏi Domain/Presentation.
- **UseCase**: đại diện cho một hành động nghiệp vụ có ý nghĩa (`GetPosts`).
- **DI**: `configureDependencies()` là composition root; tạo và liên kết các implementation với abstraction. UI chỉ nhận `PostsBloc` qua `BlocProvider`.

## Khởi tạo ứng dụng

`WidgetsFlutterBinding.ensureInitialized()` bảo đảm Flutter binding sẵn sàng trước khi thực hiện khởi tạo phụ thuộc có thể cần framework. `configureDependencies()` đăng ký các dependency với GetIt trước `runApp()`. `BlocProvider` cung cấp BLoC cho widget tree và tự đóng BLoC khi widget được dispose.

## Unit test và tính độc lập

`get_posts_test.dart` mock `PostsRepository` (abstraction) và kiểm thử UseCase mà không cần HTTP, API thật hay Data Source. Đây là bằng chứng tầng Domain không cần biết nguồn dữ liệu cụ thể. Test model xác minh parse JSON. Không cần gọi mạng để chạy test.

## Xử lý lỗi / giới hạn demo

- Lỗi HTTP hoặc JSON được ném từ Data Source và được BLoC chuyển thành trạng thái lỗi hiển thị.
- Demo chưa có phân trang, cache, xác thực hoặc persistence.
- API JSONPlaceholder là API giả lập phục vụ học tập; dữ liệu không phải tin tức thực.
- Nếu chạy trên Android emulator, cho phép truy cập Internet trong cấu hình Android mặc định. Thiết bị thực cần có kết nối mạng.

## Thêm tính năng

1. Tạo entity/contract/use case trong Domain trước.
2. Thêm model, data source và repository implementation trong Data.
3. Thêm event/state/BLoC và UI trong Presentation.
4. Đăng ký implementation trong `lib/core/di/injection.dart`.
5. Viết test Domain bằng mock/fake của repository abstraction.

## Thư viện

- `http`: REST request
- `get_it`: service locator / DI
- `flutter_bloc`: quản lý state
- `equatable`: so sánh state/entity
- `mocktail`: mock trong test

## Ghi chú

Mã nguồn là bộ khung demo có thể sao chép vào thư mục được tạo bằng `flutter create`. Sau khi giải nén, chạy `flutter pub get`, `flutter analyze`, `flutter test`. Chưa thể xác nhận lệnh build/test trên máy của bạn; hãy chạy các lệnh trên trong môi trường Flutter đã cài đặt.
