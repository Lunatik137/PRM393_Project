# Tổng quan kiến thức cơ bản trong dự án Origami Master

Dự án Origami Master là một ứng dụng Flutter (frontend) áp dụng các kiến trúc và công nghệ hiện đại. Dưới đây là mô tả chi tiết về cách các kiến thức cơ bản (Theme, Color, Navigation, Widget, Luồng...) được lập trình và áp dụng ở đâu trong mã nguồn dự án.

## 1. State Management & Architecture
- **BLoC (Business Logic Component)**: 
  - **Áp dụng ở đâu**: Sử dụng ở mọi Feature (ví dụ: `lib/features/auth/presentation/bloc/`, `lib/features/home/presentation/bloc/`).
  - **Cách dùng**: 
    - Khởi tạo BLoC bằng `BlocProvider` bên ngoài giao diện UI. Ví dụ: Tại màn hình chính (`lib/features/home/presentation/screens/home_screen.dart`), gọi `BlocProvider(create: (_) => getIt<FeedBloc>()..add(LoadFeed()), ...)` để load dữ liệu bảng tin khi mở trang.
    - Lắng nghe sự kiện để đổi trạng thái bằng `BlocConsumer` hoặc `BlocBuilder`. Trong file `login_screen.dart`, dùng `BlocConsumer<AuthBloc, AuthState>`: Nếu `state is Authenticated` -> Chuyển hướng thành công; Nếu `state is AuthError` -> Hiện SnackBar báo lỗi màu đỏ.
- **Dependency Injection (DI)**: 
  - **Áp dụng ở đâu**: File thiết lập chính nằm ở `lib/core/di/injection.dart`.
  - **Cách dùng**: Dùng `@injectable` trên các file Bloc hoặc Repository. Ở tầng UI, muốn gọi một Bloc nào đó thì sẽ lấy qua `getIt<T>()` thay vì khởi tạo bằng `new`.

## 2. Theme & Color (Giao diện và Màu sắc)
Hệ thống thiết kế (Design System) được đặt tập trung tại thư mục `lib/core/theme`:
- **AppColors (`app_colors.dart`)**:
  - **Áp dụng ở đâu**: Khắp mọi nơi trong dự án khi có nhu cầu fill màu UI.
  - **Cách dùng**: Không gán thẳng mã màu HEX vào giao diện mà gọi qua biến tĩnh. Ví dụ: Nền trang `LoginScreen` dùng `backgroundColor: AppColors.surfaceWhite`.
- **AppTheme (`app_theme.dart`)**: 
  - **Áp dụng ở đâu**: Được móc nối ngay vào file gốc `main.dart` thông qua `MaterialApp(theme: AppTheme.light)`.
  - **Cách dùng**: Ở đây tái định nghĩa mọi component gốc của Flutter (Material 3). Chẳng hạn, cấu hình luôn màu nền cho `ElevatedButtonThemeData`, `InputDecorationTheme`. Do đó, khi bạn code gọi một `ElevatedButton` hay `TextField` trong ứng dụng, giao diện sẽ tự động bo tròn và đổ màu chuẩn theo thiết kế chung mà không cần truyền lại tham số.
- **Typography (`app_text_styles.dart`)**: 
  - **Áp dụng ở đâu**: Các tham số `style` của widget `Text`.
  - **Cách dùng**: Cung cấp các class font định dạng sẵn. Ví dụ chữ "Welcome..." to ở màn Đăng nhập được set `style: AppTextStyles.pageTitle.copyWith(color: AppColors.primaryDark)`.

## 3. Navigation (Điều hướng)
Dự án sử dụng thư viện **`go_router`** để khai báo luồng chuyển trang thông minh:
- **Khai báo route tập trung**: 
  - **Áp dụng ở đâu**: Toàn bộ luồng được định nghĩa tại `lib/core/navigation/app_router.dart`. Tên route cụ thể để tránh gõ sai được gom vào `route_names.dart` (`RouteNames.home`, `RouteNames.login`...).
- **Cách dùng chuyển trang**: 
  - Chuyển đè thêm một trang mới (Push): Dùng `context.pushNamed(RouteNames.search)` (ví dụ ở icon tìm kiếm trên `HomeScreen`).
  - Thay thế hẳn màn hình hiện tại (Go): Dùng `context.goNamed(RouteNames.home)` (khi đăng nhập thành công ở `LoginScreen`).
- **Auth Redirect (Guard Navigation)**: 
  - **Áp dụng ở đâu**: Nằm ở logic thuộc tính `redirect` bên trong `GoRouter`. 
  - Cơ chế: Nó theo dõi stream của `AuthBloc`. Mỗi khi chuyển trang, nó đọc xem người dùng đã login chưa (`authState`). Nếu vào những trang private mà chưa login, nó sẽ ép `return '/login'` để bảo vệ ứng dụng khỏi các link lạ xâm nhập khi chưa đăng nhập.

## 4. Widgets (Thành phần UI tái sử dụng)
Các Widget dùng chung để tiết kiệm code và đồng nhất giao diện nằm tại `lib/core/widgets/`:
- **Thẻ tin tức (FeedPostCard)**:
  - Nằm ở `lib/features/home/presentation/widgets/feed_post_card.dart`.
  - **Cách dùng**: Trong trang `HomeScreen`, lúc lặp qua list `state.posts`, thay vì vẽ UI từ đầu, ta gọi thẻ `<FeedPostCard creatorAvatarPath="..." ... />` để vẽ các thẻ bảng tin hoàn chỉnh với ảnh và nút Like, Comment.
- **Thanh tiêu đề (AppHeader)**:
  - Nằm ở `lib/core/widgets/app_header.dart`. Dùng làm AppBar chuẩn của dự án có sẵn khoảng cách chuẩn chỉnh và Logo tích hợp.
- **Các class nhỏ khác**: Nút bấm `PrimaryButton`, các hiệu ứng thẻ bao ngoài `VisibilityBadge`.

## 5. Luồng hoạt động chính (App Flow)
Dựa vào mã nguồn và kiến trúc thư mục, các luồng hoạt động cụ thể:
1. **Khởi động & Xác thực (Splash -> Home/Login)**: 
   - Khi run app, router đi vào `initialLocation: '/splash'`. Tại màn hình Splash, ứng dụng giả lập chạy một vài giây đợi setup, GoRouter sẽ nghe state từ `AuthBloc`, từ đó phân luồng ném người dùng qua giao diện Đăng Nhập hoặc Bảng tin.
2. **Bottom Navigation & Tabs**: 
   - Trong `app_router.dart`, chức năng **`StatefulShellRoute.indexedStack`** được dùng. Nó giúp ứng dụng có giao diện thanh menu dưới đáy (Home, Explore, Gallery, Profile). Điểm mạnh của nó là giữ lại toàn bộ state cuộn màn hình khi bạn ấn chuyển tab (Bạn cuộn tab Home xuống dưới, khi ấn qua Explore rồi ấn lại Home nó vẫn ở đúng vị trí đó).
3. **Luồng sự kiện logic**:
   - Khi có tác động UI (Ví dụ: bấm Like post trong `FeedPostCard`), thay vì code gọi API trực tiếp, UI sẽ bắn event `context.read<FeedBloc>().add(LikePost(post.id))` về cho tầng BLoC xử lý. BLoC sẽ làm việc với Repository và trả về `state` thay đổi màu sắc trái tim sau. Việc này áp dụng nguyên tắc phân tách logic và giao diện rất chuẩn.
