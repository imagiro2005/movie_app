# PhePhim — Flutter Clean Architecture & Dependency Injection

> **Môn học:** Lập trình Đa nền tảng  
> **Trường Đại học Bách Khoa — Đại học Đà Nẵng (Khoa Điện tử - Viễn thông)**  
> **Giảng viên hướng dẫn:** TS. Nguyễn Duy Nhật Viễn  
> **Chủ đề 04:** Kiến trúc ứng dụng Flutter — Clean Architecture & Dependency Injection (DI)

---

##  Lộ trình phát triển dự án theo từng tuần (Weekly Roadmap)

- [x] **Tuần 1 (Foundation Milestone):**
  - Xây dựng khung kiến trúc 3 lớp chuẩn: `Domain` (Pure Dart), `Data` (REST API), `Presentation` (BLoC).
  - Áp dụng nguyên lý đảo ngược phụ thuộc (DIP) và Repository Pattern.
  - Cấu hình Dependency Injection bằng Service Locator `get_it`.
  - Khởi tạo ứng dụng an toàn với `WidgetsFlutterBinding.ensureInitialized()` và `BlocProvider`.
  - Bộ kiểm thử tự động (Unit Test) cho tầng Domain bằng kỹ thuật Mocking với `mocktail` (100% Pass).
- [ ] **Tuần 2 (Feature Expansion Milestone):**
  - Màn hình Chi tiết phim (Movie Details, diễn viên, thời lượng, trailer).
  - Tích hợp bộ nhớ đệm ngoại tuyến (Offline Caching với SQLite / Hive).
- [ ] **Tuần 3 (Interactive & Polish Milestone):**
  - Chức năng tìm kiếm phim thời gian thực áp dụng kỹ thuật Debounce Stream.
  - Tối ưu hóa giao diện với hiệu ứng chuyển động Hero Animation.
- [ ] **Tuần 4 (Final Delivery Milestone):**
  - Hoàn thiện kiểm thử Widget & Integration Test, đóng gói ứng dụng đa nền tảng.

---

##  Sơ đồ kiến trúc 3 lớp tuần 1

```mermaid
graph TD
    subgraph Presentation_Layer ["1. Presentation Layer (UI & State)"]
        UI["MoviesPage\n(Widget hiển thị danh sách, Loading, Error)"]
        Bloc["MoviesBloc\n(MoviesRequested -> MoviesLoading/Success/Failure)"]
        UI -->|Gửi MoviesRequested| Bloc
        Bloc -->|Phát MoviesState| UI
    end

    subgraph Domain_Layer ["2. Domain Layer (Pure Dart - Lõi nghiệp vụ)"]
        UC["GetMovies UseCase\n(Thực thi nghiệp vụ lấy phim)"]
        Entity["Movie Entity\n(id, title, overview, posterUrl, rating)"]
        RepoContract["MoviesRepository Interface\n(Hợp đồng trừu tượng)"]
        
        Bloc -->|Gọi call()| UC
        UC -->|Gọi getMovies()| RepoContract
        UC -.->|Trả về| Entity
    end

    subgraph Data_Layer ["3. Data Layer (Nguồn dữ liệu & Hạ tầng)"]
        RepoImpl["MoviesRepositoryImpl\n(Triển khai MoviesRepository)"]
        RemoteDS["MoviesRemoteDataSource\n(Gọi REST API qua HTTP Client)"]
        Model["MovieModel\n(JSON DTO kế thừa từ Movie Entity)"]
        API["Public REST API\n(Máy chủ máy tính/Internet)"]
        
        RepoImpl -.->|Implements (DIP)| RepoContract
        RepoImpl -->|Gọi getMovies()| RemoteDS
        RemoteDS -->|HTTP GET Request| API
        API -->>|JSON Response| RemoteDS
        RemoteDS -->|Parse JSON thành| Model
        Model -.->|Kế thừa| Entity
    end

    subgraph DI_Container ["Composition Root (core/di/injection.dart)"]
        GetIt["Service Locator (get_it)\nĐăng ký: Client -> RemoteDS -> RepoImpl -> GetMovies -> MoviesBloc"]
        GetIt -.->|Tiêm phụ thuộc| Bloc
        GetIt -.->|Tiêm phụ thuộc| UC
        GetIt -.->|Tiêm phụ thuộc| RepoImpl
    end
```

---

##  Luồng dữ liệu (Data Flow) khi người dùng mở ứng dụng

1. Người dùng mở ứng dụng → `MoviesPage` gửi sự kiện `MoviesRequested` vào `MoviesBloc`.
2. `MoviesBloc` phát trạng thái `MoviesLoading` (UI hiển thị thanh chờ xoay vòng).
3. `MoviesBloc` gọi UseCase `GetMovies()`.
4. `GetMovies` chỉ biết Interface trừu tượng `MoviesRepository` thuộc tầng Domain.
5. `MoviesRepositoryImpl` ở tầng Data thực thi hợp đồng, gọi `MoviesRemoteDataSource`.
6. `MoviesRemoteDataSource` gửi yêu cầu HTTP GET tới REST API, nhận phản hồi và chuyển mã JSON thành `MovieModel`.
7. Dữ liệu được trả ngược: Data Source → Repository → UseCase → BLoC.
8. `MoviesBloc` phát trạng thái `MoviesSuccess(movies)` → `MoviesPage` vẽ lại giao diện danh sách phim kèm hình ảnh poster và điểm đánh giá.
9. Nếu mất mạng hoặc máy chủ lỗi: Data Source ném ngoại lệ → `MoviesBloc` phát `MoviesFailure` → `MoviesPage` hiển thị giao diện báo lỗi kèm nút **"Thử lại"**.

---

##  Cấu trúc mã nguồn Tuần 1

```text
lib/
  main.dart                           # WidgetsBinding.ensureInitialized & runApp
  app.dart                            # MaterialApp & BlocProvider
  core/
    di/
      injection.dart                  # Composition Root cấu hình get_it
  features/movies/
    domain/                           # TẦNG DOMAIN (Pure Dart)
      entities/movie.dart             # Movie entity
      repositories/movies_repository.dart # Interface trừu tượng
      usecases/get_movies.dart        # UseCase GetMovies
    data/                             # TẦNG DATA
      models/movie_model.dart         # Model DTO parse JSON
      datasources/movies_remote_data_source.dart # HTTP REST Client
      repositories/movies_repository_impl.dart   # Implement MoviesRepository
    presentation/                     # TẦNG PRESENTATION
      bloc/movies_bloc.dart           # BLoC quản lý trạng thái
      pages/movies_page.dart          # Giao diện danh sách, Loading, Error, Dialog Kiến trúc
test/
  features/movies/
    domain/usecases/get_movies_test.dart        # Mock repository test UseCase
    data/models/movie_model_test.dart           # Test parse JSON sang Model
    presentation/bloc/movies_bloc_test.dart     # Mock usecase test BLoC độc lập
```

---

##  Hướng dẫn khởi chạy

### 1. Cài đặt các gói phụ thuộc
```bash
flutter pub get
```

### 2. Kiểm tra phân tích tĩnh
```bash
flutter analyze
```

### 3. Chạy toàn bộ Unit Tests (Không cần kết nối mạng)
```bash
flutter test
```
*Kết quả:* **7/7 tests Passed 100%**.

### 4. Khởi chạy ứng dụng
- Chạy trên Google Chrome (Khuyến nghị cho buổi demo nhanh):
  ```bash
  flutter run -d chrome
  ```
- Chạy trên Microsoft Edge:
  ```bash
  flutter run -d edge
  ```
- Chạy trên thiết bị thật Android / Máy ảo:
  ```bash
  flutter run
  ```

---

##  Minh chứng Tầng Presentation không phụ thuộc trực tiếp vào Data Source

Trong file `test/features/movies/presentation/bloc/movies_bloc_test.dart`:
```dart
// Mock UseCase - Presentation hoàn toàn không cần biết Data Source là gì
class MockGetMovies extends Mock implements GetMovies {}

blocTest<MoviesBloc, MoviesState>(
  'phát ra [MoviesLoading, MoviesSuccess] khi UseCase trả về dữ liệu thành công',
  build: () {
    when(() => mockGetMovies()).thenAnswer((_) async => tMovies);
    return bloc;
  },
  act: (bloc) => bloc.add(const MoviesRequested()),
  expect: () => [
    const MoviesLoading(),
    const MoviesSuccess(tMovies),
  ],
);
```
- Khi chạy test này, không hề có bất kỳ cuộc gọi HTTP nào được thực hiện.
- `MoviesBloc` chỉ nhận dữ liệu từ `GetMovies` UseCase.
- Nếu ngày mai đổi REST API thành GraphQL hay Database cục bộ, code của tầng Presentation và Domain **hoàn toàn không cần thay đổi một dòng nào**.
