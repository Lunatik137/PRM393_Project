class Chapter {
  final String title;
  final String content;

  Chapter({
    required this.title,
    required this.content,
  });
}

class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String description;
  final List<Chapter> chapters;
  int currentChapterIndex;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.description,
    required this.chapters,
    this.currentChapterIndex = 0,
  });

  double get progress {
    if (chapters.isEmpty) return 0.0;
    return (currentChapterIndex + 1) / chapters.length;
  }
}
