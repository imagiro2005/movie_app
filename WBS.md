# BẢNG PHÂN CÔNG CÔNG VIỆC (WORK BREAKDOWN STRUCTURE - WBS)

**Dự án:** Ứng dụng Phim ảnh CineStream — Clean Architecture & Dependency Injection (DI)  
**Môn học:** Lập trình Đa nền tảng  
**Khoa:** Điện tử và Trí tuệ Nhân tạo — Trường Đại học Bách Khoa, Đại học Đà Nẵng  
**Quy mô nhóm:** 2 Thành viên  

---

## 1. Bảng phân công vai trò & Nhiệm vụ chính

| TT | Thành viên | Vai trò đảm nhận | Nhiệm vụ chi tiết | Tỷ lệ đóng góp |
|:---:|:---|:---|:---|:---:|
| **1** | **Thành viên 1** *(Trưởng nhóm)* | • Business Logic<br>• State Management<br>• Dependency Injection | • Thiết kế & hiện thực tầng **Domain** (Entities, UseCases: `GetTrendingMovies`, `GetNowPlayingMovies`, `GetMovieDetails`, `SearchMovies`, abstract `MovieRepository`).<br>• Cấu hình Service Locator & DI (`get_it` + `injectable_generator`).<br>• Xây dựng các **BLoC** (TrendingMoviesBloc, NowPlayingMoviesBloc, MovieDetailBloc, SearchMoviesBloc).<br>• Viết toàn bộ **Unit Tests** cho tầng Domain & Presentation (Mocking repository với `mocktail`). | **50%** |
| **2** | **Thành viên 2** | • UI Design<br>• Database / REST API<br>• Báo cáo & Slide | • Xây dựng **Data Layer** (Models DTOs, `MovieRemoteDataSource` tích hợp Dio REST API, `MovieRepositoryImpl` với cơ chế Fallback Demo).<br>• Thiết kế giao diện Dark Cinema Theme hiện đại (Widgets: `MovieCard`, `TrendingCarousel`, `HorizontalMovieList`, `RatingBadge`).<br>• Xây dựng các trang UI: `HomePage`, `MovieDetailPage`, `SearchPage`, `ArchitectureDiagramPage`.<br>• Soạn thảo tài liệu báo cáo, vẽ sơ đồ Mermaid Data Flow và hoàn thiện Slide thuyết trình. | **50%** |

---

## 2. Chi tiết phân rã công việc (WBS Elements)

### Giai đoạn 1: Khảo sát yêu cầu & Thiết lập kiến trúc (Phase 1)
- [x] Khảo sát yêu cầu Chủ đề 04: Clean Architecture 3 lớp, DIP, Repository Pattern, get_it/injectable, WidgetsBinding, MultiBlocProvider. *(Cả nhóm)*
- [x] Khởi tạo dự án Flutter `movie_app`, cấu hình `pubspec.yaml` với các thư viện cần thiết. *(Thành viên 1)*
- [x] Thiết lập biến môi trường `.env` và API Constants cho The Movie Database (TMDB). *(Thành viên 2)*

### Giai đoạn 2: Xây dựng tầng Domain & Core (Phase 2)
- [x] Định nghĩa `Failure` & `Exception` hierarchy trong `core/error/`. *(Thành viên 1)*
- [x] Tạo generic interface `UseCase<T, Params>`. *(Thành viên 1)*
- [x] Định nghĩa Entities: `Movie`, `MovieDetail`, `Cast`. *(Thành viên 1)*
- [x] Thiết lập hợp đồng trừu tượng (Contract) `MovieRepository`. *(Thành viên 1)*
- [x] Cài đặt các UseCase nghiệp vụ: `GetTrendingMovies`, `GetNowPlayingMovies`, `GetTopRatedMovies`, `GetMovieDetails`, `SearchMovies`. *(Thành viên 1)*

### Giai đoạn 3: Xây dựng tầng Data & REST API (Phase 3)
- [x] Tạo Data Models (DTOs): `MovieModel`, `MovieDetailModel`, `CastModel` kế thừa từ Entities và hỗ trợ JSON Serialization. *(Thành viên 2)*
- [x] Triển khai `MovieRemoteDataSource` sử dụng `Dio` kết nối REST API TMDB kèm bộ dữ liệu giả lập dự phòng (Smart Fallback). *(Thành viên 2)*
- [x] Triển khai `MovieRepositoryImpl` thực thi `MovieRepository` và xử lý ngoại lệ thành `Either<Failure, T>`. *(Thành viên 2)*

### Giai đoạn 4: Dependency Injection & State Management (Phase 4)
- [x] Cấu hình Service Locator `get_it` và `@InjectableInit` tự động sinh mã với `build_runner`. *(Thành viên 1)*
- [x] Xây dựng các BLoCs với Event, State, Business Logic (`TrendingMoviesBloc`, `NowPlayingMoviesBloc`, `MovieDetailBloc`, `SearchMoviesBloc`). *(Thành viên 1)*
- [x] Cấu hình `WidgetsFlutterBinding.ensureInitialized()` và `MultiBlocProvider` tại `main.dart`. *(Thành viên 1)*

### Giai đoạn 5: Xây dựng giao diện người dùng (Presentation UI) (Phase 5)
- [x] Xây dựng Design System Dark Cinema (`AppColors`, `AppTheme`). *(Thành viên 2)*
- [x] Phát triển custom widgets: `RatingBadge`, `MovieCard`, `TrendingCarousel`, `HorizontalMovieList`. *(Thành viên 2)*
- [x] Hoàn thiện các trang màn hình:
  - `HomePage`: Slider phim thịnh hành, danh sách phim đang chiếu, pull-to-refresh. *(Thành viên 2)*
  - `MovieDetailPage`: Poster/Backdrop, đánh giá, thể loại, tóm tắt, danh sách diễn viên. *(Thành viên 2)*
  - `SearchPage`: Thanh tìm kiếm với debounce, kết quả dạng lưới. *(Thành viên 2)*
  - `ArchitectureDiagramPage`: Màn hình trực quan hóa sơ đồ 3 lớp Clean Architecture và nguyên lý DIP ngay trên app. *(Thành viên 2)*

### Giai đoạn 6: Kiểm thử Unit Test (Phase 6)
- [x] Viết Unit Test cho tầng Domain (`GetTrendingMovies`, `GetMovieDetails`, `SearchMovies`) với dependency `MovieRepository` được mock qua `mocktail`. *(Thành viên 1)*
- [x] Viết Unit Test cho `MovieRepositoryImpl` kiểm tra việc ánh xạ `ServerException` sang `ServerFailure`. *(Thành viên 1)*
- [x] Viết Unit Test cho `TrendingMoviesBloc` với `bloc_test`, chứng minh Presentation hoàn toàn không phụ thuộc trực tiếp vào Data Source. *(Thành viên 1)*
- [x] Đạt kết quả kiểm thử: **11/11 tests Passed** (100%). *(Thành viên 1)*

### Giai đoạn 7: Hoàn thiện tài liệu & Bàn giao (Phase 7)
- [x] Soạn thảo `README.md` chuẩn đồ án với sơ đồ luồng dữ liệu (Data Flow) dạng Mermaid. *(Thành viên 2)*
- [x] Hoàn thiện bảng WBS phân công công việc. *(Cả nhóm)*
- [x] Thiết kế Slide thuyết trình PowerPoint (`BaoCao_Chude04_CleanArchitecture_DI.pptx`) bám sát mẫu `MauBaocaoTuan.pptx`. *(Thành viên 2)*
