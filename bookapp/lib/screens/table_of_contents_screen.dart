import 'package:flutter/material.dart';
import '../models/book.dart';
import 'reading_screen.dart';

class TableOfContentsScreen extends StatefulWidget {
  final Book book;

  const TableOfContentsScreen({super.key, required this.book});

  @override
  State<TableOfContentsScreen> createState() => _TableOfContentsScreenState();
}

class _TableOfContentsScreenState extends State<TableOfContentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Mục lục',
          style: TextStyle(color: Color(0xFF1F1F1F), fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1F1F)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.book.chapters.length,
        itemBuilder: (context, index) {
          final isReading = index == widget.book.currentChapterIndex;
          String status = 'Chưa đọc';
          if (index < widget.book.currentChapterIndex) {
            status = 'Đã đọc';
          } else if (index == widget.book.currentChapterIndex) {
            status = 'Đang đọc';
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isReading ? const Color(0xFF0B4F1C) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                widget.book.chapters[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isReading ? Colors.white : const Color(0xFF1F1F1F),
                ),
              ),
              subtitle: Text(
                status,
                style: TextStyle(
                  color: isReading ? Colors.white70 : Colors.grey,
                  fontSize: 12,
                ),
              ),
              trailing: Icon(
                Icons.play_circle_outline,
                color: isReading ? Colors.white : const Color(0xFF0B4F1C),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReadingScreen(
                      book: widget.book,
                      chapterIndex: index,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
            ),
          );
        },
      ),
    );
  }
}
