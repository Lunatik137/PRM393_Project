import 'package:flutter/material.dart';
import '../models/book.dart';

class ReadingScreen extends StatefulWidget {
  final Book book;
  final int chapterIndex;

  const ReadingScreen({
    super.key,
    required this.book,
    required this.chapterIndex,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  late int _currentChapterIndex;
  bool _isBookmarked = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.chapterIndex;
    widget.book.currentChapterIndex = _currentChapterIndex;
  }

  void _updateChapter(int index) {
    setState(() {
      _currentChapterIndex = index;
      widget.book.currentChapterIndex = index;
    });
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _goToNextChapter() {
    if (_currentChapterIndex < widget.book.chapters.length - 1) {
      _updateChapter(_currentChapterIndex + 1);
    }
  }

  void _goToPreviousChapter() {
    if (_currentChapterIndex > 0) {
      _updateChapter(_currentChapterIndex - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapter = widget.book.chapters[_currentChapterIndex];
    final totalChapters = widget.book.chapters.length;
    final progress = (_currentChapterIndex + 1) / totalChapters;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1F1F)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Chương ${_currentChapterIndex + 1} / $totalChapters',
          style: const TextStyle(color: Color(0xFF1F1F1F), fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? const Color(0xFF0B4F1C) : const Color(0xFF1F1F1F),
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F1F1F),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.book.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const Divider(height: 40, thickness: 1),
                  Text(
                    chapter.content + ("\n\nĐây là nội dung chi tiết của ${chapter.title}. " * 5),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1F1F1F),
                      fontFamily: 'Serif',
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Page Navigation Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: _currentChapterIndex > 0 ? _goToPreviousChapter : null,
                        icon: const Icon(Icons.arrow_back_ios, size: 16),
                        label: const Text('Chương trước'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF0B4F1C),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _currentChapterIndex < widget.book.chapters.length - 1
                            ? _goToNextChapter
                            : null,
                        icon: const Text('Chương sau'),
                        label: const Icon(Icons.arrow_forward_ios, size: 16),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF0B4F1C),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          // Bottom Progress Indicator
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chương ${_currentChapterIndex + 1} / $totalChapters',
                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: const Color(0xFFEEEEEE),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0B4F1C)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
