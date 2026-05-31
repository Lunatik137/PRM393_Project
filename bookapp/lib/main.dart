import 'package:flutter/material.dart';
import 'screens/library_screen.dart';

void main() {
  runApp(const SereneReaderApp());
}

class SereneReaderApp extends StatelessWidget {
  const SereneReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serene Reader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF0B4F1C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B4F1C),
          primary: const Color(0xFF0B4F1C),
        ),
        fontFamily: 'Inter', // Defaulting to Inter if available, otherwise sans-serif
      ),
      home: const LibraryScreen(),
    );
  }
}
