import 'package:flutter/material.dart';
import '../models/book.dart';
import '../data/sample_data.dart';
import 'book_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _searchText = '';
  String _selectedFilter = 'Tất cả';
  final Set<int> _savedBookIds = {};

  @override
  Widget build(BuildContext context) {
    // Filter logic
    final List<Book> filteredBooks = sampleBooks.where((book) {
      final matchesSearch = book.title.toLowerCase().contains(_searchText.toLowerCase()) ||
          book.author.toLowerCase().contains(_searchText.toLowerCase());

      final matchesSaved = _selectedFilter == 'Đã lưu'
          ? _savedBookIds.contains(book.id)
          : true;

      return matchesSearch && matchesSaved;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Serene Reader',
          style: TextStyle(
            color: Color(0xFF1F1F1F),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search and Filters
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm sách hoặc tác giả...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Tabs
                Row(
                  children: [
                    _buildFilterTab('Tất cả'),
                    const SizedBox(width: 8),
                    _buildFilterTab('Đã lưu'),
                  ],
                ),
              ],
            ),
          ),
          
          Expanded(
            child: filteredBooks.isEmpty
                ? Center(
                    child: Text(
                      _selectedFilter == 'Đã lưu' ? 'Chưa có sách đã lưu' : 'Không tìm thấy sách',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      if (_selectedFilter == 'Tất cả' && _searchText.isEmpty) ...[
                        const Text(
                          'Tiếp tục đọc',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        _buildContinueReadingCard(context, sampleBooks[0]),
                        const SizedBox(height: 24),
                        const Text(
                          'Thư viện của bạn',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                      ],
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          return _buildBookItem(context, filteredBooks[index]);
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0B4F1C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueReadingCard(BuildContext context, Book book) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
        setState(() {}); // Refresh library when coming back
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0B4F1C),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(book.coverUrl, width: 60, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(book.author, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: book.progress,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, Book book) {
    final isSaved = _savedBookIds.contains(book.id);
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
        );
        setState(() {}); // Refresh library when coming back
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 4))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(book.coverUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSaved) {
                          _savedBookIds.remove(book.id);
                        } else {
                          _savedBookIds.add(book.id);
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withValues(alpha: 0.9),
                      radius: 16,
                      child: Icon(
                        isSaved ? Icons.bookmark : Icons.bookmark_border,
                        size: 18,
                        color: isSaved ? const Color(0xFF0B4F1C) : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(book.author, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
