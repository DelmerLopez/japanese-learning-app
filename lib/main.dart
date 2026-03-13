import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/home/home_screen.dart';

void main() {
  runApp(
    // Wrap the entire app in a ProviderScope to initialize Riverpod
    const ProviderScope(child: N5KanjiApp()),
  );
}

class N5KanjiApp extends StatelessWidget {
  const N5KanjiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JLPT N5 Kanji Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff0f0c29),
        fontFamily: 'Inter',
      ),
      home: const HomeScreen(),
    );
  }
}
