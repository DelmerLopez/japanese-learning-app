import 'package:flutter/material.dart';

class Vocabulary {
  final String word;
  final String reading;
  final String romaji;
  final String meaning;
  final String meaningEs;

  const Vocabulary({
    required this.word,
    required this.reading,
    required this.romaji,
    required this.meaning,
    required this.meaningEs,
  });
}

class VocabularyTopic {
  final String id;
  final String nameEn;
  final String nameEs;
  final IconData icon;
  final List<Vocabulary> words;

  const VocabularyTopic({
    required this.id,
    required this.nameEn,
    required this.nameEs,
    required this.icon,
    required this.words,
  });
}
