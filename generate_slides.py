import pptx
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN
from pptx.dml.color import RGBColor

def create_presentation():
    prs = pptx.Presentation('Requirements/MauBaocaoTuan.pptx')

    # Slide 1: Trang bìa
    slide1 = prs.slides[0]
    for shape in slide1.shapes:
        if shape.has_text_frame:
            text = shape.text_frame.text
            if '<<' in text or 'Tên chủ đề' in text:
                shape.text_frame.text = 'KIẾN TRÚC FLUTTER — CLEAN ARCHITECTURE\nVÀ DEPENDENCY INJECTION (DI)'
                for p in shape.text_frame.paragraphs:
                    p.font.size = Pt(26)
                    p.font.bold = True
                    p.font.color.rgb = RGBColor(190, 15, 20)
            elif 'SVTH:' in text:
                shape.text_frame.text = 'SVTH:\n1. Thành viên 1 (Trưởng nhóm)\n2. Thành viên 2'
                for p in shape.text_frame.paragraphs:
                    p.font.size = Pt(16)

    # Slide 2: Nội dung
    slide2 = prs.slides[1]
    for shape in slide2.shapes:
        if shape.has_text_frame and shape != slide2.shapes[0]:
            tf = shape.text_frame
            tf.clear()
            items = [
                '1. Đặt vấn đề & Mục tiêu đề tài',
                '2. Kiến trúc Clean Architecture 3 lớp (Presentation / Domain / Data)',
                '3. Nguyên lý đảo ngược phụ thuộc (DIP) & Repository Pattern',
                '4. Dependency Injection với get_it & injectable',
                '5. Cơ chế khởi tạo: WidgetsBinding & MultiBlocProvider',
                '6. Ứng dụng Demo thực tế: CineStream Movie Explorer',
                '7. Kiểm thử tự động (Unit Test) tầng Domain & Decoupling Proof',
                '8. Bảng phân công công việc (WBS) & Kết luận'
            ]
            for it in items:
                p = tf.add_paragraph()
                p.text = it
                p.font.size = Pt(18)
                p.space_after = Pt(10)

    # Slide 3: Phân công công việc (WBS)
    slide3 = prs.slides[2]
    for shape in slide3.shapes:
        if shape.has_table:
            table = shape.table
            table.cell(1, 1).text = 'Thành viên 1 (Trưởng nhóm)'
            table.cell(1, 2).text = 'Business Logic, State Management (BLoC), Dependency Injection, Domain Unit Tests'
            table.cell(1, 3).text = '50%'

            table.cell(2, 1).text = 'Thành viên 2'
            table.cell(2, 2).text = 'UI Design, Data Layer (REST API & DTOs), Báo cáo & Slide thuyết trình'
            table.cell(2, 3).text = '50%'

            for row in table.rows:
                for cell in row.cells:
                    for p in cell.text_frame.paragraphs:
                        p.font.size = Pt(13)

    # Slide 4: Clean Architecture 3 lớp
    slide4 = prs.slides[3]
    slide4.shapes[0].text_frame.text = '1. Kiến trúc Clean Architecture 3 Lớp'
    for shape in slide4.shapes:
        if shape.has_text_frame and shape != slide4.shapes[0]:
            tf = shape.text_frame
            tf.clear()
            points = [
                '• Presentation Layer: Chứa UI (Widgets, Pages) và State Management (BLoC/Cubit). Chỉ phụ thuộc vào Domain UseCase.',
                '• Domain Layer (Core Business): Độc lập hoàn toàn (Pure Dart), chứa Entities, UseCases và Repository Interface.',
                '• Data Layer: Phụ trách lấy dữ liệu từ REST API (Dio) hoặc Local Database. Triển khai (implement) Repository Interface của Domain.',
                '• Quy tắc phụ thuộc (The Dependency Rule): Mọi phụ thuộc chỉ được phép chỉ vào trong (hướng về Domain).'
            ]
            for pt in points:
                p = tf.add_paragraph()
                p.text = pt
                p.font.size = Pt(17)
                p.space_after = Pt(12)

    # Slide 5: DIP & Repository Pattern
    layout_content = prs.slide_layouts[1]
    slide5 = prs.slides.add_slide(layout_content)
    slide5.shapes[0].text_frame.text = '2. Nguyên lý Đảo ngược Phụ thuộc (DIP)'
    tf5 = slide5.shapes[1].text_frame
    tf5.clear()
    pts5 = [
        '• Định nghĩa DIP: Module cấp cao (Domain) không phụ thuộc trực tiếp vào module cấp thấp (Data). Cả hai đều phụ thuộc vào Abstraction.',
        '• Repository Pattern: Domain định nghĩa interface MovieRepository. Data layer thực thi MovieRepositoryImpl.',
        '• Lợi ích then chốt: Presentation & Domain có thể kiểm thử hoàn toàn độc lập với API thật bằng cách Mock repository.',
        '• Dễ dàng hoán đổi Data Source (REST API, GraphQL, SQLite, Firebase) mà không cần sửa bất kỳ dòng mã nào ở Domain/Presentation.'
    ]
    for pt in pts5:
        p = tf5.add_paragraph()
        p.text = pt
        p.font.size = Pt(17)
        p.space_after = Pt(12)

    # Slide 6: DI with get_it & injectable
    slide6 = prs.slides.add_slide(layout_content)
    slide6.shapes[0].text_frame.text = '3. Dependency Injection (get_it + injectable)'
    tf6 = slide6.shapes[1].text_frame
    tf6.clear()
    pts6 = [
        '• get_it (Service Locator): Quản lý vòng đời và cung cấp instance của UseCase, Repository, BLoC ở mọi nơi trong ứng dụng.',
        '• injectable + build_runner: Tự động quét các annotation (@lazySingleton, @injectable) và sinh mã khởi tạo compile-time.',
        '• WidgetsFlutterBinding.ensureInitialized(): Đảm bảo kết nối giữa Flutter Engine và Dart Framework trước khi nạp .env và DI.',
        '• MultiBlocProvider: Tích hợp BLoC vào Widget Tree theo vòng đời widget, tự động quản lý dispose() giải phóng bộ nhớ.'
    ]
    for pt in pts6:
        p = tf6.add_paragraph()
        p.text = pt
        p.font.size = Pt(17)
        p.space_after = Pt(12)

    # Slide 7: Demo CineStream App & Unit Tests
    slide7 = prs.slides.add_slide(layout_content)
    slide7.shapes[0].text_frame.text = '4. Demo Ứng Dụng CineStream & Unit Tests'
    tf7 = slide7.shapes[1].text_frame
    tf7.clear()
    pts7 = [
        '• Ứng dụng CineStream Movie Explorer: Kết nối TMDB REST API, hiển thị phim thịnh hành, đang chiếu, chi tiết và tìm kiếm.',
        '• Màn hình trực quan hóa kiến trúc Clean Architecture tích hợp ngay bên trong ứng dụng.',
        '• Cơ chế Smart Fallback: Đảm bảo ứng dụng chạy mượt mà ngay cả khi chưa có API Key hoặc mất kết nối mạng trong lúc thuyết trình.',
        '• Kết quả Unit Test: 11/11 tests Passed 100% (Mocktail + BlocTest chứng minh tầng Presentation không phụ thuộc vào Data Source).'
    ]
    for pt in pts7:
        p = tf7.add_paragraph()
        p.text = pt
        p.font.size = Pt(17)
        p.space_after = Pt(12)

    # Slide 8: Tài liệu tham khảo
    slide_ref = prs.slides[4]
    slide_ref.shapes[0].text_frame.text = '5. Tài liệu tham khảo'
    tf_ref = slide_ref.shapes[1].text_frame
    tf_ref.clear()
    refs = [
        '1. Robert C. Martin (2017) - Clean Architecture: A Craftsman Guide to Software Structure and Design.',
        '2. Flutter Official Documentation: Architectural Overview & State Management with BLoC.',
        '3. Reso Coder: Flutter Clean Architecture & TDD Course.',
        '4. The Movie Database (TMDB) API v3 Developer Documentation.'
    ]
    for r in refs:
        p = tf_ref.add_paragraph()
        p.text = r
        p.font.size = Pt(17)
        p.space_after = Pt(12)

    prs.save('Requirements/BaoCao_Chude04_CleanArchitecture_DI.pptx')
    prs.save('BaoCao_Chude04_CleanArchitecture_DI.pptx')
    print('Successfully generated presentation!')

if __name__ == '__main__':
    create_presentation()
