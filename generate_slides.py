import sys
import pptx
from pptx.util import Inches, Pt
from pptx.enum.text import PP_ALIGN, MSO_ANCHOR
from pptx.dml.color import RGBColor
from pptx.enum.shapes import MSO_SHAPE

# ==========================================
# COLOR PALETTE (Professional Light Theme)
# ==========================================
COLOR_PRIMARY_DARK = RGBColor(15, 23, 42)      # Slate 900
COLOR_SECONDARY_DARK = RGBColor(30, 41, 59)    # Slate 800
COLOR_ROYAL_BLUE = RGBColor(29, 78, 216)       # Blue 700
COLOR_ACCENT_BLUE = RGBColor(37, 99, 235)      # Blue 600
COLOR_CYAN = RGBColor(14, 116, 144)            # Cyan 700
COLOR_EMERALD = RGBColor(16, 149, 93)          # Green 600
COLOR_ROSE = RGBColor(225, 29, 72)             # Rose 600
COLOR_AMBER = RGBColor(217, 119, 6)            # Amber 600
COLOR_CARD_BG = RGBColor(248, 250, 252)        # Slate 50
COLOR_CARD_BORDER = RGBColor(203, 213, 225)    # Slate 300
COLOR_LIGHT_BLUE = RGBColor(239, 246, 255)     # Blue 50
COLOR_LIGHT_GREEN = RGBColor(240, 253, 244)    # Green 50
COLOR_LIGHT_AMBER = RGBColor(254, 252, 232)    # Amber 50
COLOR_TEXT_PRIMARY = RGBColor(15, 23, 42)      # Slate 900
COLOR_TEXT_SECONDARY = RGBColor(71, 85, 105)   # Slate 600
COLOR_TEXT_MUTED = RGBColor(100, 116, 139)     # Slate 500
COLOR_WHITE = RGBColor(255, 255, 255)
COLOR_MAROON = RGBColor(153, 27, 27)           # Red 800 (DUT Accent)

FONT_HEADING = 'Segoe UI'
FONT_BODY = 'Segoe UI'

def add_header(slide, title_text, category_text="CHỦ ĐỀ 04: CLEAN ARCHITECTURE & DEPENDENCY INJECTION"):
    """Adds a standardized professional header banner to the slide."""
    # Top primary color bar
    top_bar = slide.shapes.add_shape(
        MSO_SHAPE.RECTANGLE,
        Inches(0), Inches(0), Inches(13.333), Inches(0.08)
    )
    top_bar.fill.solid()
    top_bar.fill.fore_color.rgb = COLOR_ROYAL_BLUE
    top_bar.line.color.rgb = COLOR_ROYAL_BLUE

    # Category Pill / Badge
    cat_box = slide.shapes.add_shape(
        MSO_SHAPE.ROUNDED_RECTANGLE,
        Inches(0.8), Inches(0.28), Inches(4.8), Inches(0.36)
    )
    cat_box.fill.solid()
    cat_box.fill.fore_color.rgb = COLOR_LIGHT_BLUE
    cat_box.line.color.rgb = COLOR_ROYAL_BLUE
    cat_box.line.width = Pt(1)
    tf_c = cat_box.text_frame
    tf_c.word_wrap = True
    p_c = tf_c.paragraphs[0]
    p_c.text = category_text.upper()
    p_c.font.size = Pt(10)
    p_c.font.bold = True
    p_c.font.name = FONT_HEADING
    p_c.font.color.rgb = COLOR_ROYAL_BLUE
    p_c.alignment = PP_ALIGN.CENTER

    # Main Title
    title_box = slide.shapes.add_textbox(Inches(0.75), Inches(0.68), Inches(11.8), Inches(0.7))
    tf_t = title_box.text_frame
    tf_t.word_wrap = True
    tf_t.margin_left = tf_t.margin_top = tf_t.margin_right = tf_t.margin_bottom = 0
    p_t = tf_t.paragraphs[0]
    p_t.text = title_text
    p_t.font.size = Pt(22)
    p_t.font.bold = True
    p_t.font.name = FONT_HEADING
    p_t.font.color.rgb = COLOR_PRIMARY_DARK

def add_footer(slide, current_slide, total_slides=12):
    """Adds a standardized footer with branding and page numbering."""
    # Divider line
    line = slide.shapes.add_shape(
        MSO_SHAPE.RECTANGLE,
        Inches(0.8), Inches(6.92), Inches(11.733), Inches(0.02)
    )
    line.fill.solid()
    line.fill.fore_color.rgb = COLOR_CARD_BORDER
    line.line.color.rgb = COLOR_CARD_BORDER

    # Footer left text
    f_box = slide.shapes.add_textbox(Inches(0.8), Inches(7.0), Inches(9.5), Inches(0.35))
    tf_f = f_box.text_frame
    tf_f.margin_left = tf_f.margin_top = tf_f.margin_right = tf_f.margin_bottom = 0
    p_f = tf_f.paragraphs[0]
    p_f.text = "Ứng dụng PhePhim | Lập trình Đa nền tảng — Khoa ĐTVT, Trường ĐH Bách Khoa - ĐH Đà Nẵng | GVHD: TS. Nguyễn Duy Nhật Viễn"
    p_f.font.size = Pt(9.5)
    p_f.font.name = FONT_BODY
    p_f.font.color.rgb = COLOR_TEXT_MUTED

    # Page number
    p_box = slide.shapes.add_textbox(Inches(11.0), Inches(7.0), Inches(1.5), Inches(0.35))
    tf_p = p_box.text_frame
    tf_p.margin_left = tf_p.margin_top = tf_p.margin_right = tf_p.margin_bottom = 0
    p_p = tf_p.paragraphs[0]
    p_p.text = f"Trang {current_slide} / {total_slides}"
    p_p.font.size = Pt(9.5)
    p_p.font.bold = True
    p_p.font.name = FONT_HEADING
    p_p.font.color.rgb = COLOR_ROYAL_BLUE
    p_p.alignment = PP_ALIGN.RIGHT

def add_card(slide, left, top, width, height, title="", bg_color=COLOR_CARD_BG, border_color=COLOR_CARD_BORDER, border_width=1):
    """Creates a rounded styled card container with an optional title header."""
    shape = slide.shapes.add_shape(
        MSO_SHAPE.ROUNDED_RECTANGLE,
        Inches(left), Inches(top), Inches(width), Inches(height)
    )
    shape.fill.solid()
    shape.fill.fore_color.rgb = bg_color
    shape.line.color.rgb = border_color
    shape.line.width = Pt(border_width)
    tf = shape.text_frame
    tf.word_wrap = True
    tf.margin_left = Inches(0.2)
    tf.margin_right = Inches(0.2)
    tf.margin_top = Inches(0.18)
    tf.margin_bottom = Inches(0.18)

    if title:
        p = tf.paragraphs[0]
        p.text = title
        p.font.size = Pt(14)
        p.font.bold = True
        p.font.name = FONT_HEADING
        p.font.color.rgb = COLOR_PRIMARY_DARK
        p.space_after = Pt(8)
    return shape

def create_presentation():
    prs = pptx.Presentation()
    prs.slide_width = Inches(13.333)
    prs.slide_height = Inches(7.5)
    blank_layout = prs.slide_layouts[6]

    # =========================================================================
    # SLIDE 1: TRANG BÌA (Title Slide)
    # =========================================================================
    slide1 = prs.slides.add_slide(blank_layout)

    # Decorative top bar
    bar1 = slide1.shapes.add_shape(MSO_SHAPE.RECTANGLE, Inches(0), Inches(0), Inches(13.333), Inches(0.12))
    bar1.fill.solid()
    bar1.fill.fore_color.rgb = COLOR_MAROON
    bar1.line.color.rgb = COLOR_MAROON

    # School & Faculty Badge
    sch_badge = slide1.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.0), Inches(0.6), Inches(11.333), Inches(0.55))
    sch_badge.fill.solid()
    sch_badge.fill.fore_color.rgb = COLOR_CARD_BG
    sch_badge.line.color.rgb = COLOR_MAROON
    sch_badge.line.width = Pt(1.5)
    tf_sch = sch_badge.text_frame
    p_sch = tf_sch.paragraphs[0]
    p_sch.text = "ĐẠI HỌC ĐÀ NẴNG — TRƯỜNG ĐẠI HỌC BÁCH KHOA — KHOA ĐIỆN TỬ - VIỄN THÔNG"
    p_sch.font.size = Pt(13)
    p_sch.font.bold = True
    p_sch.font.name = FONT_HEADING
    p_sch.font.color.rgb = COLOR_MAROON
    p_sch.alignment = PP_ALIGN.CENTER

    # Course Name Tag
    course_box = slide1.shapes.add_textbox(Inches(1.0), Inches(1.3), Inches(11.333), Inches(0.4))
    tf_c = course_box.text_frame
    p_c = tf_c.paragraphs[0]
    p_c.text = "HỌC PHẦN: LẬP TRÌNH ĐA NỀN TẢNG (CROSS-PLATFORM PROGRAMMING)"
    p_c.font.size = Pt(13)
    p_c.font.bold = True
    p_c.font.name = FONT_HEADING
    p_c.font.color.rgb = COLOR_ROYAL_BLUE
    p_c.alignment = PP_ALIGN.CENTER

    # Main Project Title Box
    title_box = slide1.shapes.add_shape(MSO_SHAPE.ROUNDED_RECTANGLE, Inches(1.0), Inches(1.85), Inches(11.333), Inches(2.3))
    title_box.fill.solid()
    title_box.fill.fore_color.rgb = COLOR_LIGHT_BLUE
    title_box.line.color.rgb = COLOR_ROYAL_BLUE
    title_box.line.width = Pt(2)
    tf_main = title_box.text_frame
    tf_main.word_wrap = True
    tf_main.margin_left = tf_main.margin_right = Inches(0.5)

    p_sub = tf_main.paragraphs[0]
    p_sub.text = "BÁO CÁO TIẾN ĐỘ ĐỒ ÁN — TUẦN 1"
    p_sub.font.size = Pt(14)
    p_sub.font.bold = True
    p_sub.font.name = FONT_HEADING
    p_sub.font.color.rgb = COLOR_ROYAL_BLUE
    p_sub.alignment = PP_ALIGN.CENTER
    p_sub.space_after = Pt(6)

    p_m1 = tf_main.add_paragraph()
    p_m1.text = "CHỦ ĐỀ 04: KIẾN TRÚC ỨNG DỤNG FLUTTER\nCLEAN ARCHITECTURE & DEPENDENCY INJECTION (DI)"
    p_m1.font.size = Pt(24)
    p_m1.font.bold = True
    p_m1.font.name = FONT_HEADING
    p_m1.font.color.rgb = COLOR_PRIMARY_DARK
    p_m1.alignment = PP_ALIGN.CENTER
    p_m1.space_after = Pt(8)

    p_m2 = tf_main.add_paragraph()
    p_m2.text = "Ứng dụng thực nghiệm: PhePhim (Movie Explorer — Giao diện sáng & REST API thật)"
    p_m2.font.size = Pt(14)
    p_m2.font.italic = True
    p_m2.font.name = FONT_BODY
    p_m2.font.color.rgb = COLOR_TEXT_SECONDARY
    p_m2.alignment = PP_ALIGN.CENTER

    # Instructor Card (Bottom Left)
    inst_card = add_card(slide1, 1.0, 4.4, 5.5, 2.2, "GIẢNG VIÊN HƯỚNG DẪN", COLOR_CARD_BG, COLOR_CARD_BORDER)
    tf_i = inst_card.text_frame
    p_i1 = tf_i.add_paragraph()
    p_i1.text = "• TS. Nguyễn Duy Nhật Viễn"
    p_i1.font.size = Pt(15)
    p_i1.font.bold = True
    p_i1.font.color.rgb = COLOR_PRIMARY_DARK
    p_i1.space_after = Pt(6)

    p_i2 = tf_i.add_paragraph()
    p_i2.text = "Khoa Điện tử - Viễn thông\nTrường Đại học Bách Khoa — Đại học Đà Nẵng"
    p_i2.font.size = Pt(13)
    p_i2.font.color.rgb = COLOR_TEXT_SECONDARY

    # Students Card (Bottom Right)
    stud_card = add_card(slide1, 6.833, 4.4, 5.5, 2.2, "SINH VIÊN THỰC HIỆN", COLOR_CARD_BG, COLOR_CARD_BORDER)
    tf_s = stud_card.text_frame
    
    p_s1 = tf_s.add_paragraph()
    p_s1.text = "1. Huỳnh Ngọc Tịnh Phong (Trưởng nhóm)"
    p_s1.font.size = Pt(13.5)
    p_s1.font.bold = True
    p_s1.font.color.rgb = COLOR_PRIMARY_DARK
    p_s1_sub = tf_s.add_paragraph()
    p_s1_sub.text = "    Vai trò: Lõi nghiệp vụ (Domain), BLoC State Management, DI & Unit Testing"
    p_s1_sub.font.size = Pt(11)
    p_s1_sub.font.color.rgb = COLOR_TEXT_SECONDARY
    p_s1_sub.space_after = Pt(6)

    p_s2 = tf_s.add_paragraph()
    p_s2.text = "2. Phạm Nhật Tân"
    p_s2.font.size = Pt(13.5)
    p_s2.font.bold = True
    p_s2.font.color.rgb = COLOR_PRIMARY_DARK
    p_s2_sub = tf_s.add_paragraph()
    p_s2_sub.text = "    Vai trò: UI Design (Light Theme), Data Layer (REST API & DTOs), Báo cáo & Slide"
    p_s2_sub.font.size = Pt(11)
    p_s2_sub.font.color.rgb = COLOR_TEXT_SECONDARY

    add_footer(slide1, 1)

    # =========================================================================
    # SLIDE 2: MỤC LỤC BÁO CÁO (Agenda)
    # =========================================================================
    slide2 = prs.slides.add_slide(blank_layout)
    add_header(slide2, "Mục Lục Nội Dung Báo Cáo Tiến Độ")

    # Left Column: Lý thuyết & Kiến trúc
    card_ag1 = add_card(slide2, 0.8, 1.5, 5.7, 5.2, "PHẦN I: CƠ SỞ LÝ THUYẾT & KIẾN TRÚC", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_ag1 = card_ag1.text_frame
    items_ag1 = [
        ("1. Bảng phân công công việc (WBS)", "Phân rã nhiệm vụ chi tiết và tỷ lệ đóng góp của từng thành viên."),
        ("2. Tổng quan Clean Architecture", "Quy tắc phụ thuộc (The Dependency Rule) & 3 đặc tính then chốt."),
        ("3. Cấu trúc chi tiết Tầng Domain", "Pure Dart: Thực thể (Entities), Hợp đồng (Repositories) & Use Cases."),
        ("4. Cấu trúc chi tiết Tầng Data", "REST API thật, Mô hình chuyển đổi (DTOs) & Triển khai Repository."),
        ("5. Cấu trúc chi tiết Tầng Presentation", "Mô hình BLoC (Event/State) & Giao diện sáng PhePhim (Light Theme).")
    ]
    for title, desc in items_ag1:
        p_t = tf_ag1.add_paragraph()
        p_t.text = title
        p_t.font.size = Pt(13.5)
        p_t.font.bold = True
        p_t.font.color.rgb = COLOR_ROYAL_BLUE
        p_d = tf_ag1.add_paragraph()
        p_d.text = f"   → {desc}"
        p_d.font.size = Pt(11.5)
        p_d.font.color.rgb = COLOR_TEXT_SECONDARY
        p_d.space_after = Pt(6)

    # Right Column: Nguyên lý & Kết quả đạt được
    card_ag2 = add_card(slide2, 6.833, 1.5, 5.7, 5.2, "PHẦN II: NGUYÊN LÝ & KẾT QUẢ ĐẠT ĐƯỢC", COLOR_CARD_BG, COLOR_EMERALD, 1.5)
    tf_ag2 = card_ag2.text_frame
    items_ag2 = [
        ("6. Nguyên lý Đảo ngược phụ thuộc (DIP)", "Bản chất chữ D trong SOLID và Repository Pattern trong Flutter."),
        ("7. Dependency Injection & Khởi tạo", "Service Locator get_it, WidgetsBinding & MultiBlocProvider."),
        ("8. Những kết quả cụ thể đã làm được", "Ứng dụng PhePhim chạy REST API thật, xử lý lỗi mất mạng & nút Retry."),
        ("9. Kiểm thử tự động (Unit Test)", "Bộ 8/8 tests 100% Passed bằng mocktail và bloc_test, minh chứng Decoupling."),
        ("10. Lộ trình Tuần 2 & Tổng kết", "Kế hoạch mở rộng chi tiết phim, bộ nhớ đệm Offline Cache và kết luận.")
    ]
    for title, desc in items_ag2:
        p_t = tf_ag2.add_paragraph()
        p_t.text = title
        p_t.font.size = Pt(13.5)
        p_t.font.bold = True
        p_t.font.color.rgb = COLOR_EMERALD
        p_d = tf_ag2.add_paragraph()
        p_d.text = f"   → {desc}"
        p_d.font.size = Pt(11.5)
        p_d.font.color.rgb = COLOR_TEXT_SECONDARY
        p_d.space_after = Pt(6)

    add_footer(slide2, 2)

    # =========================================================================
    # SLIDE 3: BẢNG PHÂN CÔNG CÔNG VIỆC (WBS)
    # =========================================================================
    slide3 = prs.slides.add_slide(blank_layout)
    add_header(slide3, "1. Bảng Phân Công Công Việc Chi Tiết (WBS)")

    # Table creation
    rows, cols = 3, 4
    left, top, width, height = Inches(0.8), Inches(1.5), Inches(11.733), Inches(4.0)
    table_shape = slide3.shapes.add_table(rows, cols, left, top, width, height)
    table = table_shape.table
    table.columns[0].width = Inches(2.2)
    table.columns[1].width = Inches(2.4)
    table.columns[2].width = Inches(5.633)
    table.columns[3].width = Inches(1.5)

    headers = ["Thành viên", "Vai trò đảm nhận", "Nhiệm vụ cụ thể đã thực hiện trong Tuần 1", "Tỷ lệ đóng góp"]
    for i, h in enumerate(headers):
        cell = table.cell(0, i)
        cell.fill.solid()
        cell.fill.fore_color.rgb = COLOR_ROYAL_BLUE
        p = cell.text_frame.paragraphs[0]
        p.text = h
        p.font.size = Pt(13)
        p.font.bold = True
        p.font.color.rgb = COLOR_WHITE
        p.alignment = PP_ALIGN.CENTER

    data_rows = [
        (
            "Huỳnh Ngọc Tịnh Phong\n(Trưởng nhóm)",
            "• Business Logic\n• State Management\n• Dependency Injection\n• Unit Testing",
            "• Thiết kế & hiện thực tầng Domain (Movie entity, MoviesRepository contract, GetMovies UseCase).\n• Cấu hình DI Container với get_it trong injection.dart (Service Locator).\n• Xây dựng MoviesBloc quản lý trạng thái tải phim (Initial, Loading, Success, Failure).\n• Viết toàn bộ bộ kiểm thử tự động Unit Tests (mocktail, bloc_test đạt 8/8 tests passed).",
            "50%\n(Hoàn thành 100% mục tiêu)"
        ),
        (
            "Phạm Nhật Tân",
            "• UI Design\n• Data Layer & REST API\n• Báo cáo & Slide",
            "• Hiện thực Data Layer: MoviesRemoteDataSource gọi REST API thật (GitHub Raw JSON 24 phim).\n• Xây dựng MovieModel (fromJson/toJson) và MoviesRepositoryImpl thực thi hợp đồng Domain.\n• Thiết kế giao diện sáng PhePhim (Light Theme), Card phim bo góc, poster, IMDb rating.\n• Xây dựng màn hình báo lỗi mất mạng kèm nút 'Thử lại' (Retry) và soạn thảo Slide thuyết trình.",
            "50%\n(Hoàn thành 100% mục tiêu)"
        )
    ]

    for row_idx, row_data in enumerate(data_rows, start=1):
        bg = COLOR_LIGHT_BLUE if row_idx == 1 else COLOR_CARD_BG
        for col_idx, text in enumerate(row_data):
            cell = table.cell(row_idx, col_idx)
            cell.fill.solid()
            cell.fill.fore_color.rgb = bg
            tf = cell.text_frame
            tf.word_wrap = True
            p = tf.paragraphs[0]
            p.text = text
            p.font.size = Pt(11.5)
            p.font.color.rgb = COLOR_PRIMARY_DARK
            if col_idx in [0, 1, 3]:
                p.alignment = PP_ALIGN.CENTER
                p.font.bold = (col_idx == 0 or col_idx == 3)

    # Note card at bottom
    note_box = add_card(slide3, 0.8, 5.7, 11.733, 1.0, "", COLOR_LIGHT_GREEN, COLOR_EMERALD, 1)
    tf_n = note_box.text_frame
    p_n = tf_n.paragraphs[0]
    p_n.text = "✔ ĐÁNH GIÁ TIẾN ĐỘ TUẦN 1: Cả hai thành viên đã hoàn thành 100% khối lượng công việc được phân công."
    p_n.font.size = Pt(12)
    p_n.font.bold = True
    p_n.font.color.rgb = COLOR_EMERALD
    p_n_sub = tf_n.add_paragraph()
    p_n_sub.text = "Kiến trúc 3 lớp kết nối chặt chẽ, hoạt động trơn tru với REST API thật và 100% Unit Tests đã vượt qua."
    p_n_sub.font.size = Pt(11)
    p_n_sub.font.color.rgb = COLOR_TEXT_SECONDARY

    add_footer(slide3, 3)

    # =========================================================================
    # SLIDE 4: TỔNG QUAN CLEAN ARCHITECTURE & QUY TẮC PHỤ THUỘC
    # =========================================================================
    slide4 = prs.slides.add_slide(blank_layout)
    add_header(slide4, "2. Tổng Quan Clean Architecture & Quy Tắc Phụ Thuộc")

    # Left Card: Triết lý & Quy tắc phụ thuộc
    card_left = add_card(slide4, 0.8, 1.5, 5.7, 5.2, "TRIẾT LÝ VÀ QUY TẮC PHỤ THUỘC (DEPENDENCY RULE)", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf_l = card_left.text_frame
    
    pts_l = [
        ("Nguồn gốc & Mục tiêu:", "Do Robert C. Martin (Uncle Bob) khởi xướng. Mục tiêu tối thượng là phân tách ranh giới rõ ràng (Separation of Concerns), giúp mã nguồn dễ hiểu, dễ kiểm thử và độc lập với các công nghệ bên ngoài."),
        ("Quy tắc phụ thuộc (The Dependency Rule):", "'Source code dependencies must point only inward, toward higher-level policies'. Mọi sự phụ thuộc trong mã nguồn CHỈ ĐƯỢC PHÉP hướng vào trong, về phía các chính sách nghiệp vụ cấp cao (Domain)."),
        ("Tính độc lập tuyệt đối của Domain:", "Tầng Domain nằm ở tâm điểm, là Pure Dart. Domain TUYỆT ĐỐI KHÔNG biết tới sự tồn tại của Flutter UI, HTTP Client, Database, hay bất kỳ thư viện bên thứ ba nào."),
        ("Tính khả chuyển (Flexibility):", "Giao diện (UI) hoặc Nguồn dữ liệu (Data Source) là các chi tiết ngoại vi (Details), có thể hoán đổi linh hoạt mà không làm ảnh hưởng đến lõi nghiệp vụ.")
    ]
    for t, d in pts_l:
        p1 = tf_l.add_paragraph()
        p1.text = f"• {t}"
        p1.font.size = Pt(12.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_ROYAL_BLUE
        p2 = tf_l.add_paragraph()
        p2.text = f"  {d}"
        p2.font.size = Pt(11)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Right Card: 3 Lớp Kiến Trúc Trong Dự Án PhePhim
    card_right = add_card(slide4, 6.833, 1.5, 5.7, 5.2, "3 LỚP KIẾN TRÚC CHUẨN TRONG FLUTTER", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_r = card_right.text_frame

    layers = [
        ("1. Presentation Layer (Tầng Giao Diện)", COLOR_ROYAL_BLUE, [
            "• Chứa UI Widgets (MoviesPage, MovieCard, Dialogs) và State Management (MoviesBloc).",
            "• Lắng nghe tương tác của người dùng, gửi Event và lắng nghe State để vẽ giao diện.",
            "• Chỉ được phép phụ thuộc vào UseCase của tầng Domain."
        ]),
        ("2. Domain Layer (Tầng Lõi Nghiệp Vụ - Tâm điểm)", COLOR_MAROON, [
            "• Chứa Entities (Movie), UseCases (GetMovies) và Repository Contract (MoviesRepository).",
            "• Viết bằng Pure Dart 100%, không import bất kỳ package UI hoặc Network nào.",
            "• Là trái tim bất biến của ứng dụng, quy định toàn bộ luật nghiệp vụ."
        ]),
        ("3. Data Layer (Tầng Dữ Liệu & Hạ Tầng)", COLOR_EMERALD, [
            "• Chứa Remote Data Source (gọi REST API), Model DTOs (fromJson/toJson).",
            "• Chứa MoviesRepositoryImpl thực thi giao tiếp trừu tượng của Domain (DIP).",
            "• Phụ thuộc vào Domain Layer và cung cấp dữ liệu thật cho hệ thống."
        ])
    ]
    for l_title, color, bullets in layers:
        p_t = tf_r.add_paragraph()
        p_t.text = l_title
        p_t.font.size = Pt(13)
        p_t.font.bold = True
        p_t.font.color.rgb = color
        for b in bullets:
            p_b = tf_r.add_paragraph()
            p_b.text = f"  {b}"
            p_b.font.size = Pt(10.5)
            p_b.font.color.rgb = COLOR_TEXT_PRIMARY
        p_b.space_after = Pt(6)

    add_footer(slide4, 4)

    # =========================================================================
    # SLIDE 5: CHI TIẾT TẦNG 1 - DOMAIN LAYER (Pure Dart)
    # =========================================================================
    slide5 = prs.slides.add_slide(blank_layout)
    add_header(slide5, "3. Cấu Trúc Chi Tiết Tầng 1 — Domain Layer (Pure Dart)")

    col_w = 3.65
    gap = 0.39
    
    # Card 1: Entities
    c1 = add_card(slide5, 0.8, 1.5, col_w, 5.2, "THỰC THỂ (ENTITIES)", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf1 = c1.text_frame
    p = tf1.add_paragraph()
    p.text = "Tệp: lib/features/movies/domain/entities/movie.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_ROYAL_BLUE
    p.space_after = Pt(8)

    desc1 = [
        ("Bản chất:", "Đại diện cho mô hình nghiệp vụ thuần túy của ứng dụng, không chứa logic phân tích JSON hay database."),
        ("Thuộc tính:", "id, title, overview, posterUrl, rating, releaseDate."),
        ("Tính chất Bất biến (Immutable):", "Tất cả các trường đều là final, đảm bảo trạng thái dữ liệu không bị thay đổi ngầm ngoài tầm kiểm soát."),
        ("Không phụ thuộc Framework:", "Sử dụng Dart thuần, không import flutter/material.dart, có thể tái sử dụng cho backend Dart hoặc web.")
    ]
    for h, b in desc1:
        p1 = tf1.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf1.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Card 2: Repository Contract
    c2 = add_card(slide5, 0.8 + col_w + gap, 1.5, col_w, 5.2, "HỢP ĐỒNG (REPOSITORIES)", COLOR_CARD_BG, COLOR_MAROON, 1.5)
    tf2 = c2.text_frame
    p = tf2.add_paragraph()
    p.text = "Tệp: .../domain/repositories/movies_repository.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_MAROON
    p.space_after = Pt(8)

    desc2 = [
        ("Bản chất:", "Là một Abstract Class đóng vai trò bản hợp đồng (Interface) quy định các phương thức nghiệp vụ."),
        ("Định nghĩa phương thức:", "abstract class MoviesRepository {\n  Future<List<Movie>> getMovies();\n}"),
        ("Ý nghĩa kiến trúc:", "Domain chỉ đưa ra yêu cầu (CẦN lấy danh sách phim), hoàn toàn KHÔNG quan tâm dữ liệu được lấy từ REST API, Firebase hay SQLite."),
        ("Phục vụ Mocking:", "Nhờ Interface này, tầng Domain và Presentation có thể dễ dàng được kiểm thử với Mock Repository.")
    ]
    for h, b in desc2:
        p1 = tf2.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf2.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Card 3: Use Cases
    c3 = add_card(slide5, 0.8 + 2 * (col_w + gap), 1.5, col_w, 5.2, "NGHIỆP VỤ (USE CASES)", COLOR_CARD_BG, COLOR_EMERALD, 1.5)
    tf3 = c3.text_frame
    p = tf3.add_paragraph()
    p.text = "Tệp: lib/features/movies/domain/usecases/get_movies.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_EMERALD
    p.space_after = Pt(8)

    desc3 = [
        ("Bản chất:", "Mỗi UseCase đóng gói DUY NHẤT một thao tác nghiệp vụ cụ thể của người dùng (Single Responsibility Principle)."),
        ("Triển khai trong dự án:", "class GetMovies {\n  final MoviesRepository repository;\n  Future<List<Movie>> call() {\n    return repository.getMovies();\n  }\n}"),
        ("Constructor Injection:", "Nhận MoviesRepository qua constructor, giúp loại bỏ khớp nối cứng."),
        ("Khả năng tái sử dụng:", "Nhiều ViewModel/BLoC khác nhau có thể cùng gọi chung một UseCase mà không bị lặp mã nguồn.")
    ]
    for h, b in desc3:
        p1 = tf3.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf3.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    add_footer(slide5, 5)

    # =========================================================================
    # SLIDE 6: CHI TIẾT TẦNG 2 - DATA LAYER (REST API & Triển khai)
    # =========================================================================
    slide6 = prs.slides.add_slide(blank_layout)
    add_header(slide6, "4. Cấu Trúc Chi Tiết Tầng 2 — Data Layer (REST API & DTOs)")

    # Card 1: Remote Data Source
    c1 = add_card(slide6, 0.8, 1.5, col_w, 5.2, "NGUỒN DỮ LIỆU (DATA SOURCES)", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf1 = c1.text_frame
    p = tf1.add_paragraph()
    p.text = "Tệp: .../datasources/movies_remote_data_source.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_ROYAL_BLUE
    p.space_after = Pt(8)

    desc1 = [
        ("Nhiệm vụ:", "Trực tiếp tương tác với REST API thông qua http.Client của Flutter."),
        ("Endpoint REST API thật:", "Kết nối trực tiếp tới máy chủ dữ liệu phim GitHub Raw JSON (24 phim chiếu rạp với đầy đủ poster, rating, diễn viên)."),
        ("Xử lý ngoại lệ mạng:", "Kiểm tra HTTP Status Code: nếu == 200 thì giải mã JSON; nếu thất bại hoặc mất mạng sẽ ném ra ServerException()."),
        ("Decoupling HTTP Client:", "Nhận http.Client qua hàm tạo, cho phép mock request khi viết Unit Test.")
    ]
    for h, b in desc1:
        p1 = tf1.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf1.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Card 2: Model DTOs
    c2 = add_card(slide6, 0.8 + col_w + gap, 1.5, col_w, 5.2, "MÔ HÌNH DỮ LIỆU (MODELS / DTO)", COLOR_CARD_BG, COLOR_AMBER, 1.5)
    tf2 = c2.text_frame
    p = tf2.add_paragraph()
    p.text = "Tệp: lib/features/movies/data/models/movie_model.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_AMBER
    p.space_after = Pt(8)

    desc2 = [
        ("Kế thừa từ Entity:", "class MovieModel extends Movie. Là Data Transfer Object (DTO) mở rộng từ Entity của Domain."),
        ("Phương thức fromJson():", "Phân tích cú pháp JSON an toàn. Xử lý các trường hợp dữ liệu phong phú (posterurl / poster, rating chuỗi hoặc số thực)."),
        ("Phương thức toJson():", "Chuyển đổi ngược từ Object thành Map JSON phục vụ lưu trữ đệm hoặc gửi request."),
        ("Bảo vệ tầng Domain:", "Giữ cho Domain không bị ảnh hưởng khi cấu trúc JSON của API máy chủ thay đổi tên trường.")
    ]
    for h, b in desc2:
        p1 = tf2.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf2.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Card 3: Repository Implementation
    c3 = add_card(slide6, 0.8 + 2 * (col_w + gap), 1.5, col_w, 5.2, "HIỆN THỰC REPOSITORY (IMPL)", COLOR_CARD_BG, COLOR_EMERALD, 1.5)
    tf3 = c3.text_frame
    p = tf3.add_paragraph()
    p.text = "Tệp: .../repositories/movies_repository_impl.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_EMERALD
    p.space_after = Pt(8)

    desc3 = [
        ("Áp dụng DIP:", "class MoviesRepositoryImpl implements MoviesRepository. Hiện thực hợp đồng do tầng Domain đặt ra."),
        ("Điều phối dữ liệu:", "Gọi MoviesRemoteDataSource để lấy danh sách MovieModel, sau đó trả về dưới dạng List<Movie> (Entity)."),
        ("Xử lý lỗi tập trung:", "Bắt các ngoại lệ kỹ thuật (SocketException, ServerException) và chuyển hóa thành thông điệp nghiệp vụ sạch sẽ."),
        ("Tính sẵn sàng cho Caching:", "Dễ dàng bổ sung LocalDataSource (Hive/SQLite) để kiểm tra bộ nhớ đệm trước khi gọi API.")
    ]
    for h, b in desc3:
        p1 = tf3.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf3.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    add_footer(slide6, 6)

    # =========================================================================
    # SLIDE 7: CHI TIẾT TẦNG 3 - PRESENTATION LAYER (BLoC & UI)
    # =========================================================================
    slide7 = prs.slides.add_slide(blank_layout)
    add_header(slide7, "5. Cấu Trúc Chi Tiết Tầng 3 — Presentation Layer (BLoC & UI)")

    # Left: State Management BLoC
    c_bloc = add_card(slide7, 0.8, 1.5, 5.7, 5.2, "QUẢN LÝ TRẠNG THÁI (BLoC PATTERN)", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_b = c_bloc.text_frame
    p = tf_b.add_paragraph()
    p.text = "Tệp: lib/features/movies/presentation/bloc/movies_bloc.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_ROYAL_BLUE
    p.space_after = Pt(8)

    bloc_details = [
        ("Cơ chế phân tách:", "Tách biệt 100% logic điều khiển và giao diện UI theo mô hình Stream/Reactive."),
        ("Sự kiện (Events):", "MoviesRequested — phát ra khi màn hình khởi tạo hoặc khi người dùng nhấn nút 'Thử lại'."),
        ("Trạng thái (States):", "• MoviesInitial: Trạng thái ban đầu.\n• MoviesLoading: Đang chờ phản hồi từ mạng.\n• MoviesSuccess(movies): Tải thành công danh sách phim.\n• MoviesFailure(message): Xảy ra sự cố mạng kèm thông báo."),
        ("Luồng xử lý BLoC:", "Nhận MoviesRequested → emit(MoviesLoading) → gọi UseCase getMovies() → emit(MoviesSuccess) hoặc emit(MoviesFailure).")
    ]
    for h, b in bloc_details:
        p1 = tf_b.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf_b.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Right: UI Design & Error Handling
    c_ui = add_card(slide7, 6.833, 1.5, 5.7, 5.2, "THIẾT KẾ GIAO DIỆN SÁNG (LIGHT THEME) & XỬ LÝ LỖI", COLOR_CARD_BG, COLOR_EMERALD, 1.5)
    tf_u = c_ui.text_frame
    p = tf_u.add_paragraph()
    p.text = "Tệp: lib/features/movies/presentation/pages/movies_page.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_EMERALD
    p.space_after = Pt(8)

    ui_details = [
        ("Thương hiệu PhePhim (Light Theme):", "Sử dụng tông màu sáng chủ đạo thanh lịch, nền trắng sữa, AppBar nổi bật, card phim bo góc mềm mại kèm hiệu ứng đổ bóng tinh tế."),
        ("Trình bày trực quan:", "Hiển thị poster chất lượng cao (Amazon CDN), badge điểm IMDb màu vàng sang trọng, năm phát hành và tóm tắt cốt truyện ngắn gọn."),
        ("Xử lý lỗi mất mạng (Error Recovery):", "Khi ngắt mạng, UI không bị crash mà hiển thị màn hình báo lỗi chuyên nghiệp với Icon cảnh báo và nút 'Thử lại' (Retry) để người dùng tải lại khi có mạng."),
        ("Tương tác làm mới (Refresh Action):", "Tích hợp nút làm mới trên AppBar và cơ chế Pull-to-Refresh, gửi sự kiện MoviesRequested để cập nhật lại danh sách phim bất cứ lúc nào.")
    ]
    for h, b in ui_details:
        p1 = tf_u.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf_u.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    add_footer(slide7, 7)

    # =========================================================================
    # SLIDE 8: NGUYÊN LÝ ĐẢO NGƯỢC PHỤ THUỘC (DIP) & REPOSITORY PATTERN
    # =========================================================================
    slide8 = prs.slides.add_slide(blank_layout)
    add_header(slide8, "6. Nguyên Lý Đảo Ngược Phụ Thuộc (DIP) & Repository Pattern")

    # Top: Concept definition
    top_c = add_card(slide8, 0.8, 1.5, 11.733, 1.6, "BẢN CHẤT CỦA NGUYÊN LÝ DEPENDENCY INVERSION (CHỮ 'D' TRONG SOLID)", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_tc = top_c.text_frame
    p = tf_tc.add_paragraph()
    p.text = "1. Các module cấp cao (Domain) không được phụ thuộc vào các module cấp thấp (Data / REST API). Cả hai đều phải phụ thuộc vào lớp trừu tượng (Abstractions).\n2. Lớp trừu tượng không được phụ thuộc vào chi tiết cài đặt. Chi tiết cài đặt phải phụ thuộc vào lớp trừu tượng."
    p.font.size = Pt(12)
    p.font.color.rgb = COLOR_PRIMARY_DARK
    p.space_after = Pt(4)

    # Bottom Left: Traditional coupling
    c_trad = add_card(slide8, 0.8, 3.3, 5.7, 3.4, "MÔ HÌNH TRUYỀN THỐNG (KHỚP NỐI CHẶT)", COLOR_CARD_BG, COLOR_ROSE, 1.5)
    tf_tr = c_trad.text_frame
    items_tr = [
        ("Luồng phụ thuộc trực tiếp:", "UI / BLoC ──▶ Service Nghiệp vụ ──▶ REST API (HTTP)"),
        ("Hạn chế nghiêm trọng:", "Module cấp cao phụ thuộc cứng vào thư viện mạng (http/dio)."),
        ("Khó kiểm thử (Untestable):", "Muốn test logic nghiệp vụ buộc phải chạy API thật hoặc khởi chạy môi trường mạng."),
        ("Nguy cơ phá vỡ hệ thống:", "Khi đổi máy chủ hoặc đổi sang lưu trữ Offline, toàn bộ code nghiệp vụ phải viết lại.")
    ]
    for h, b in items_tr:
        p1 = tf_tr.add_paragraph()
        p1.text = f"✘ {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_ROSE
        p2 = tf_tr.add_paragraph()
        p2.text = f"   {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(4)

    # Bottom Right: Clean Architecture DIP
    c_dip = add_card(slide8, 6.833, 3.3, 5.7, 3.4, "CLEAN ARCHITECTURE DIP (KHỚP NỐI LỎNG)", COLOR_LIGHT_GREEN, COLOR_EMERALD, 1.5)
    tf_dp = c_dip.text_frame
    items_dp = [
        ("Mũi tên phụ thuộc bị đảo ngược:", "Presentation ──▶ UseCase ──▶ [MoviesRepository] ◀── Impl (Data)"),
        ("Bức tường trừu tượng (Barrier):", "Domain làm chủ hợp đồng MoviesRepository. Data Layer phải tuân theo Domain."),
        ("Dễ dàng kiểm thử (100% Testable):", "Thay MoviesRepositoryImpl bằng MockMoviesRepository khi chạy Unit Test."),
        ("Tự do thay thế công nghệ:", "Chuyển từ REST API sang GraphQL, Firebase hay SQLite mà không cần chạm vào Domain!")
    ]
    for h, b in items_dp:
        p1 = tf_dp.add_paragraph()
        p1.text = f"✔ {h}"
        p1.font.size = Pt(11.5)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_EMERALD
        p2 = tf_dp.add_paragraph()
        p2.text = f"   {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_PRIMARY
        p2.space_after = Pt(4)

    add_footer(slide8, 8)

    # =========================================================================
    # SLIDE 9: DEPENDENCY INJECTION (DI) & KHỞI TẠO ỨNG DỤNG
    # =========================================================================
    slide9 = prs.slides.add_slide(blank_layout)
    add_header(slide9, "7. Dependency Injection (DI) Với get_it & Khởi Tạo Ứng Dụng")

    # Left: get_it Container
    c_getit = add_card(slide9, 0.8, 1.5, 5.7, 5.2, "SERVICE LOCATOR CONTAINER (get_it)", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf_gi = c_getit.text_frame
    p = tf_gi.add_paragraph()
    p.text = "Tệp: lib/core/di/injection.dart (Composition Root)"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_ROYAL_BLUE
    p.space_after = Pt(8)

    gi_points = [
        ("Composition Root duy nhất:", "Là nơi duy nhất trong toàn bộ hệ thống biết cách kết nối các chi tiết cụ thể với nhau."),
        ("Chuỗi đăng ký phụ thuộc phân tầng:", "1. sl.registerLazySingleton(() => http.Client());\n2. sl.registerLazySingleton<MoviesRemoteDataSource>(() => MoviesRemoteDataSourceImpl(client: sl()));\n3. sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(remoteDataSource: sl()));\n4. sl.registerLazySingleton(() => GetMovies(sl()));\n5. sl.registerFactory(() => MoviesBloc(getMovies: sl()));"),
        ("Constructor Injection:", "Tất cả các class đều nhận phụ thuộc qua hàm khởi tạo, không tự ý new đối tượng.")
    ]
    for h, b in gi_points:
        p1 = tf_gi.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf_gi.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Right: Startup sequence & Lifecycle
    c_start = add_card(slide9, 6.833, 1.5, 5.7, 5.2, "CƠ CHẾ KHỞI TẠO & VÒNG ĐỜI (LIFECYCLE)", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_st = c_start.text_frame
    p = tf_st.add_paragraph()
    p.text = "Tệp: lib/main.dart & lib/app.dart"
    p.font.size = Pt(10)
    p.font.bold = True
    p.font.color.rgb = COLOR_ROYAL_BLUE
    p.space_after = Pt(8)

    st_points = [
        ("WidgetsFlutterBinding.ensureInitialized():", "Đảm bảo sự liên kết hoàn tất giữa Flutter Framework và nền tảng máy ảo (Engine/Platform Channels) trước khi nạp DI."),
        ("Khởi tạo cấu hình DI:", "Gọi configureDependencies() ngay trong hàm main() trước khi runApp(), đảm bảo tất cả singleton sẵn sàng hoạt động."),
        ("BlocProvider gắn kết Widget Tree:", "Trong app.dart, sử dụng BlocProvider(create: (_) => di.sl<MoviesBloc>()..add(const MoviesRequested())) để cung cấp BLoC."),
        ("Quản lý tài nguyên an toàn:", "BlocProvider tự động gọi moviesBloc.close() khi widget thoát khỏi cây giao diện, ngăn chặn triệt để rò rỉ bộ nhớ (Memory Leak).")
    ]
    for h, b in st_points:
        p1 = tf_st.add_paragraph()
        p1.text = f"• {h}"
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf_st.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    add_footer(slide9, 9)

    # =========================================================================
    # SLIDE 10: NHỮNG KẾT QUẢ CỤ THỂ ĐÃ LÀM ĐƯỢC TRONG TUẦN 1
    # =========================================================================
    slide10 = prs.slides.add_slide(blank_layout)
    add_header(slide10, "8. Những Kết Quả Cụ Thể Đã Làm Được Trong Tuần 1")

    # 4 Cards in 2x2 grid
    grid_w = 5.7
    grid_h = 2.5
    
    # Grid 1: REST API Thật
    g1 = add_card(slide10, 0.8, 1.5, grid_w, grid_h, "1. KẾT NỐI REST API THẬT 100%", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_g1 = g1.text_frame
    items_g1 = [
        "• Gọi dữ liệu phim thực tế từ REST API (GitHub Raw JSON), không dùng mock giả lập.",
        "• Lấy về danh sách 24 bộ phim chiếu rạp với đầy đủ thông tin: Tiêu đề, Poster (Amazon CDN), Điểm IMDb, Năm phát hành, Diễn viên và Tóm tắt.",
        "• Thời gian phản hồi nhanh, dữ liệu sạch và chuẩn xác."
    ]
    for it in items_g1:
        p = tf_g1.add_paragraph()
        p.text = it
        p.font.size = Pt(11)
        p.font.color.rgb = COLOR_PRIMARY_DARK
        p.space_after = Pt(3)

    # Grid 2: UI PhePhim Light Theme
    g2 = add_card(slide10, 6.833, 1.5, grid_w, grid_h, "2. GIAO DIỆN SÁNG (LIGHT THEME) HOÀN CHỈNH", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf_g2 = g2.text_frame
    items_g2 = [
        "• Đổi mới giao diện theo phong cách Light Theme thanh lịch, tên ứng dụng: PhePhim.",
        "• Card phim bo góc hiện đại, poster sắc nét kèm huy hiệu điểm IMDb vàng sang trọng.",
        "• Tích hợp cử chỉ kéo để làm mới (Pull-to-Refresh) và nút làm mới dữ liệu nhanh chóng trên AppBar.",
        "• Bố cục giao diện hiển thị mượt mà trên cả trình duyệt Web, Mobile và Desktop."
    ]
    for it in items_g2:
        p = tf_g2.add_paragraph()
        p.text = it
        p.font.size = Pt(11)
        p.font.color.rgb = COLOR_PRIMARY_DARK
        p.space_after = Pt(3)

    # Grid 3: Xử lý ngoại lệ & Nút Retry
    g3 = add_card(slide10, 0.8, 4.2, grid_w, grid_h, "3. PHẢN HỒI NGƯỜI DÙNG & NÚT 'THỬ LẠI' (RETRY)", COLOR_CARD_BG, COLOR_EMERALD, 1.5)
    tf_g3 = g3.text_frame
    items_g3 = [
        "• Đáp ứng trọn vẹn yêu cầu phản hồi từ thao tác người dùng (User Interaction).",
        "• Bắt ngoại lệ mất mạng/lỗi máy chủ: hiển thị màn hình báo lỗi tiếng Việt trực quan.",
        "• Tích hợp nút 'Thử lại' (Retry): Người dùng nhấn nút sẽ kích hoạt lại MoviesRequested để BLoC tải lại dữ liệu mà không cần khởi động lại ứng dụng.",
        "• Hiển thị thanh chờ (Loading Spinner) chỉn chu trong suốt quá trình tải."
    ]
    for it in items_g3:
        p = tf_g3.add_paragraph()
        p.text = it
        p.font.size = Pt(11)
        p.font.color.rgb = COLOR_PRIMARY_DARK
        p.space_after = Pt(3)

    # Grid 4: Git & Code Quality
    g4 = add_card(slide10, 6.833, 4.2, grid_w, grid_h, "4. CHUẨN MỰC MÃ NGUỒN & QUẢN LÝ GIT", COLOR_LIGHT_GREEN, COLOR_EMERALD, 1.5)
    tf_g4 = g4.text_frame
    items_g4 = [
        "• Mã nguồn đạt 0 lỗi phân tích: flutter analyze không có cảnh báo nào (0 issues).",
        "• Toàn bộ mã nguồn được lưu trữ tại GitHub: github.com/imagiro2005/movie_app.",
        "• Đã gắn Git Tag chính thức: v1.0-week1 đánh dấu cột mốc hoàn thành Tuần 1.",
        "• Lịch sử commit sạch, rõ ràng theo đúng chuẩn phân tầng Clean Architecture."
    ]
    for it in items_g4:
        p = tf_g4.add_paragraph()
        p.text = it
        p.font.size = Pt(11)
        p.font.color.rgb = COLOR_PRIMARY_DARK
        p.space_after = Pt(3)

    add_footer(slide10, 10)

    # =========================================================================
    # SLIDE 11: KIỂM THỬ TỰ ĐỘNG (UNIT TEST) & MINH CHỨNG DECOUPLING
    # =========================================================================
    slide11 = prs.slides.add_slide(blank_layout)
    add_header(slide11, "9. Kiểm Thử Tự Động (Unit Test) & Minh Chứng Decoupling")

    # Left: Test Strategy & Coverage
    c_strat = add_card(slide11, 0.8, 1.5, 5.7, 5.2, "BỘ KIỂM THỬ TỰ ĐỘNG 3 TẦNG (TEST SUITE)", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf_st = c_strat.text_frame
    
    test_cases = [
        ("1. Domain Layer Test (get_movies_test.dart):", "• Sử dụng package mocktail để Mock MoviesRepository.\n• Kiểm tra UseCase GetMovies gọi đúng hàm và trả về dữ liệu entity chính xác mà hoàn toàn KHÔNG cần kết nối mạng hay gọi API thật."),
        ("2. Data Layer Test (movie_model_test.dart):", "• Kiểm tra hàm MovieModel.fromJson() phân tích chính xác JSON thành đối tượng.\n• Xác nhận MovieModel kế thừa hoàn hảo và tương thích kiểu dữ liệu với Movie Entity."),
        ("3. Presentation Layer Test (movies_bloc_test.dart):", "• Sử dụng bloc_test kiểm tra chuỗi chuyển đổi trạng thái của MoviesBloc.\n• Khi có MoviesRequested: phát ra [MoviesLoading, MoviesSuccess] khi thành công, hoặc [MoviesLoading, MoviesFailure] khi có ngoại lệ.")
    ]
    for h, b in test_cases:
        p1 = tf_st.add_paragraph()
        p1.text = h
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_ROYAL_BLUE
        p2 = tf_st.add_paragraph()
        p2.text = f"  {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    # Right: Results & Proof of Decoupling
    c_res = add_card(slide11, 6.833, 1.5, 5.7, 5.2, "KẾT QUẢ NGHIỆM THU & GIÁ TRỊ KIẾN TRÚC", COLOR_LIGHT_GREEN, COLOR_EMERALD, 1.5)
    tf_re = c_res.text_frame

    # Green badge inside right card
    p_badge = tf_re.add_paragraph()
    p_badge.text = "★ KẾT QUẢ: 8 / 8 TESTS PASSED (100% XANH)"
    p_badge.font.size = Pt(14)
    p_badge.font.bold = True
    p_badge.font.color.rgb = COLOR_EMERALD
    p_badge.space_after = Pt(10)

    proofs = [
        ("Minh chứng cho tính Decoupling (Tách rời phụ thuộc):", "Toàn bộ bài test Domain và BLoC đều thực thi thành công trong mili-giây mà không hề tạo bất kỳ kết nối HTTP nào tới máy chủ. Điều này chứng minh tầng nghiệp vụ đã được cô lập độc lập hoàn toàn."),
        ("Phát hiện lỗi hồi quy sớm (Regression Prevention):", "Bất kỳ sự thay đổi mã nguồn nào vi phạm cấu trúc hoặc làm gãy luồng dữ liệu đều bị bộ test phát hiện ngay tại máy phát triển trước khi build."),
        ("Nền tảng vững chắc cho TDD (Test-Driven Development):", "Sẵn sàng áp dụng mở rộng kiểm thử Widget Test và Integration Test ở các giai đoạn sau.")
    ]
    for h, b in proofs:
        p1 = tf_re.add_paragraph()
        p1.text = f"✔ {h}"
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf_re.add_paragraph()
        p2.text = f"   {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_PRIMARY
        p2.space_after = Pt(6)

    add_footer(slide11, 11)

    # =========================================================================
    # SLIDE 12: LỘ TRÌNH PHÁT TRIỂN & TỔNG KẾT
    # =========================================================================
    slide12 = prs.slides.add_slide(blank_layout)
    add_header(slide12, "10. Lộ Trình Phát Triển & Tổng Kết Đồ Án")

    # Left: Roadmap
    c_road = add_card(slide12, 0.8, 1.5, 5.7, 5.2, "KẾ HOẠCH PHÁT TRIỂN TIẾP THEO (ROADMAP)", COLOR_CARD_BG, COLOR_ROYAL_BLUE, 1.5)
    tf_rd = c_road.text_frame

    milestones = [
        ("Tuần 2 — Mở Rộng Tính Năng & Bộ Nhớ Đệm (Caching):", [
            "• Xây dựng màn hình Chi tiết phim (MovieDetailPage): Trailer, đạo diễn, dàn diễn viên.",
            "• Tích hợp LocalDataSource với Hive / SQLite để lưu cache offline, giúp người dùng xem phim ngay cả khi không có mạng."
        ]),
        ("Tuần 3 — Tìm Kiếm & Tối Ưu Tương Tác:", [
            "• Tính năng tìm kiếm phim thời gian thực áp dụng kỹ thuật Debounce Stream (tránh spam API khi người dùng đang gõ phím).",
            "• Hiệu ứng chuyển cảnh Hero Animation mượt mà giữa danh sách và chi tiết."
        ]),
        ("Tuần 4 — Hoàn Thiện & Đóng Gói Ứng Dụng:", [
            "• Bổ sung Widget Test và Integration Test hoàn chỉnh.",
            "• Đóng gói và xuất bản ứng dụng đa nền tảng (Web, Android APK)."
        ])
    ]
    for phase, bullets in milestones:
        p_t = tf_rd.add_paragraph()
        p_t.text = phase
        p_t.font.size = Pt(12)
        p_t.font.bold = True
        p_t.font.color.rgb = COLOR_ROYAL_BLUE
        for b in bullets:
            p_b = tf_rd.add_paragraph()
            p_b.text = f"  {b}"
            p_b.font.size = Pt(10)
            p_b.font.color.rgb = COLOR_TEXT_SECONDARY
        p_b.space_after = Pt(4)

    # Right: Conclusion & Summary
    c_con = add_card(slide12, 6.833, 1.5, 5.7, 5.2, "TỔNG KẾT ĐÁNH GIÁ GIAI ĐOẠN 1", COLOR_LIGHT_BLUE, COLOR_ROYAL_BLUE, 1.5)
    tf_co = c_con.text_frame

    conclusions = [
        ("Hoàn thành trọn vẹn mục tiêu Tuần 1:", "Nhóm đã xây dựng thành công kiến trúc Clean Architecture 3 lớp chuẩn mực trên Flutter, áp dụng triệt để nguyên lý Đảo ngược phụ thuộc (DIP) và Dependency Injection (DI) với get_it."),
        ("Ứng dụng thực tế chất lượng cao:", "PhePhim hoạt động ổn định với dữ liệu REST API thật, giao diện sáng hiện đại, phản hồi thao tác người dùng tốt và có cơ chế xử lý lỗi mạng kèm nút Retry phục hồi tức thì."),
        ("Độ bao phủ kiểm thử ấn tượng:", "8/8 Unit tests đạt 100% Pass, chứng minh tính độc lập và khả năng mở rộng của cấu trúc mã nguồn."),
        ("Cam kết nhóm:", "Duy trì chất lượng mã nguồn cao cấp, tiếp tục phối hợp nhịp nhàng để triển khai xuất sắc các mốc tiến độ tiếp theo.")
    ]
    for h, b in conclusions:
        p1 = tf_co.add_paragraph()
        p1.text = f"★ {h}"
        p1.font.size = Pt(12)
        p1.font.bold = True
        p1.font.color.rgb = COLOR_PRIMARY_DARK
        p2 = tf_co.add_paragraph()
        p2.text = f"   {b}"
        p2.font.size = Pt(10.5)
        p2.font.color.rgb = COLOR_TEXT_SECONDARY
        p2.space_after = Pt(6)

    add_footer(slide12, 12)

    # Save presentation
    output_path = 'BaoCao_Chude04_CleanArchitecture_DI.pptx'
    try:
        prs.save(output_path)
        print(f"Presentation generated successfully: {output_path}")
    except PermissionError:
        fallback_path = 'BaoCao_Chude04_CleanArchitecture_DI_v2.pptx'
        prs.save(fallback_path)
        print(f"File đang mở trong PowerPoint. Đã lưu bản cập nhật tại: {fallback_path}")

if __name__ == '__main__':
    create_presentation()
