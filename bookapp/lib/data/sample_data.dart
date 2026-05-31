import '../models/book.dart';

final List<Book> sampleBooks = [
  Book(
    id: 1,
    title: 'Suối Nguồn',
    author: 'Ayn Rand',
    coverUrl: 'https://picsum.photos/seed/suoinguan/400/600',
    description: 'Tác phẩm kinh điển về chủ nghĩa cá nhân và sự sáng tạo, xoay quanh kiến trúc sư Howard Roark.',
    currentChapterIndex: 1, // Đang đọc chương 2
    chapters: [
      Chapter(title: 'Chương 1: Howard Roark', content: 'Howard Roark cười. Anh đứng trên một tảng đá granite cao...'),
      Chapter(title: 'Chương 2: Peter Keating', content: 'Peter Keating tốt nghiệp thủ khoa trường kiến trúc...'),
      Chapter(title: 'Chương 3: Dominique Francon', content: 'Dominique Francon nhìn xuống thành phố từ cửa sổ văn phòng...'),
      Chapter(title: 'Chương 4: Ellsworth Toohey', content: 'Ellsworth Toohey viết những bài phê bình sắc sảo...'),
      Chapter(title: 'Chương 5: Sự Sáng Tạo', content: 'Đỉnh cao của sự sáng tạo là khi con người tự do...'),
    ],
  ),
  Book(
    id: 2,
    title: 'Nhà Giả Kim',
    author: 'Paulo Coelho',
    coverUrl: 'https://picsum.photos/seed/nhagiakim/400/600',
    description: 'Hành trình đi tìm kho báu và định mệnh của chàng chăn cừu Santiago.',
    currentChapterIndex: 0, // Đang đọc chương 1
    chapters: [
      Chapter(title: 'Chương 1: Chàng chăn cừu', content: 'Tên anh là Santiago. Trời đã bắt đầu tối khi anh đến gần nhà thờ cổ...'),
      Chapter(title: 'Chương 2: Giấc mơ lạ', content: 'Santiago có một giấc mơ lặp lại về một kho báu ở Kim Tự Tháp...'),
      Chapter(title: 'Chương 3: Vị vua già', content: 'Melchizedek nói với anh về Định Mệnh của mỗi người...'),
      Chapter(title: 'Chương 4: Sa mạc', content: 'Sa mạc không bao giờ tha thứ cho những kẻ bất cẩn...'),
      Chapter(title: 'Chương 5: Kho báu', content: 'Cuối cùng anh đã hiểu kho báu thực sự nằm ở đâu...'),
    ],
  ),
  Book(
    id: 3,
    title: 'Hoàng Tử Bé',
    author: 'Antoine de Saint-Exupéry',
    coverUrl: 'https://picsum.photos/seed/hoangtube/400/600',
    description: 'Câu chuyện triết học sâu sắc về tình bạn và tình yêu thông qua góc nhìn trẻ thơ.',
    currentChapterIndex: 0,
    chapters: [
      Chapter(title: 'Chương 1: Con trăn và con voi', content: 'Lúc tôi lên sáu tuổi, tôi thấy một bức tranh tuyệt đẹp...'),
      Chapter(title: 'Chương 2: Gặp gỡ trên sa mạc', content: 'Làm ơn... vẽ cho tôi một con cừu!'),
      Chapter(title: 'Chương 3: Bông hoa duy nhất', content: 'Tôi đã không biết cách hiểu cô ấy...'),
      Chapter(title: 'Chương 4: Những hành tinh khác', content: 'Người lớn thật là kỳ lạ...'),
      Chapter(title: 'Chương 5: Bí mật của Cáo', content: 'Người ta chỉ thấy rõ bằng trái tim. Những gì cốt yếu thì mắt thường không nhìn thấy được.'),
    ],
  ),
  Book(
    id: 4,
    title: 'Sapiens',
    author: 'Yuval Noah Harari',
    coverUrl: 'https://picsum.photos/seed/sapiens/400/600',
    description: 'Lược sử loài người từ thời kỳ đồ đá đến thế kỷ 21.',
    currentChapterIndex: 0,
    chapters: [
      Chapter(title: 'Chương 1: Một động vật không có gì đặc biệt', content: 'Cách đây 100.000 năm, Trái đất có ít nhất 6 loài người...'),
      Chapter(title: 'Chương 2: Cách mạng nhận thức', content: 'Sapiens bắt đầu thống trị nhờ khả năng hư cấu...'),
      Chapter(title: 'Chương 3: Cách mạng nông nghiệp', content: 'Cạm bẫy lớn nhất của lịch sử là nông nghiệp...'),
      Chapter(title: 'Chương 4: Sự thống nhất của loài người', content: 'Tiền bạc, Đế quốc và Tôn giáo là ba nguồn lực thống nhất...'),
      Chapter(title: 'Chương 5: Cách mạng khoa học', content: 'Con người thừa nhận sự thiếu hiểu biết của mình...'),
    ],
  ),
];
