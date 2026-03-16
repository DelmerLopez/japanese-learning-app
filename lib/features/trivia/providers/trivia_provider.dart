import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/kanji.dart';
import '../../../core/data/kanji_data.dart';
import '../../../core/providers/locale_provider.dart';
import 'dart:math';

// Represents the state of the Trivia game
class TriviaState {
  final List<Kanji> questions;
  final int currentIndex;
  final int score;
  final List<String> currentOptions;
  final String? selectedOption;
  final bool isAnswered;

  TriviaState({
    required this.questions,
    required this.currentIndex,
    required this.score,
    required this.currentOptions,
    required this.selectedOption,
    required this.isAnswered,
  });

  Kanji get currentKanji => questions[currentIndex];
  bool get isGameOver => currentIndex >= questions.length - 1 && isAnswered;

  TriviaState copyWith({
    List<Kanji>? questions,
    int? currentIndex,
    int? score,
    List<String>? currentOptions,
    String? selectedOption,
    bool? isAnswered,
    bool resetSelected = false,
  }) {
    return TriviaState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      currentOptions: currentOptions ?? this.currentOptions,
      selectedOption: resetSelected
          ? null
          : (selectedOption ?? this.selectedOption),
      isAnswered: isAnswered ?? this.isAnswered,
    );
  }
}

// The Notifier handles business logic
class TriviaNotifier extends Notifier<TriviaState> {
  @override
  TriviaState build() {
    final locale = ref.watch(localeProvider);
    final isEs = locale.languageCode == 'es';
    
    final shuffledQuestions = List<Kanji>.from(n5KanjiList)..shuffle(Random());

    // Defer initialization options since state must be returned in build
    Future.microtask(() => _generateOptions(isEs));

    return TriviaState(
      questions: shuffledQuestions,
      currentIndex: 0,
      score: 0,
      currentOptions: [],
      selectedOption: null,
      isAnswered: false,
    );
  }

  void restartGame() {
    final locale = ref.read(localeProvider);
    final isEs = locale.languageCode == 'es';

    final shuffledQuestions = List<Kanji>.from(n5KanjiList)..shuffle(Random());
    state = TriviaState(
      questions: shuffledQuestions,
      currentIndex: 0,
      score: 0,
      currentOptions: [],
      selectedOption: null,
      isAnswered: false,
    );
    _generateOptions(isEs);
  }

  void _generateOptions(bool isEs) {
    if (state.questions.isEmpty) return;

    final correct = isEs ? state.currentKanji.meaningEs : state.currentKanji.meaning;
    final r = Random();
    final incorrect = <String>{};

    // Pick 2 random wrong meanings
    while (incorrect.length < 2) {
      final randomKanji = n5KanjiList[r.nextInt(n5KanjiList.length)];
      final meaning = isEs ? randomKanji.meaningEs : randomKanji.meaning;
      if (meaning != correct) {
        incorrect.add(meaning);
      }
    }

    // Combine and shuffle
    final options = [correct, ...incorrect]..shuffle(r);

    state = state.copyWith(currentOptions: options);
  }

  void selectOption(String option) {
    if (state.isAnswered) return; // Prevent multiple clicks

    final locale = ref.read(localeProvider);
    final isEs = locale.languageCode == 'es';
    final correctMeaning = isEs ? state.currentKanji.meaningEs : state.currentKanji.meaning;
    final isCorrect = option == correctMeaning;

    state = state.copyWith(
      selectedOption: option,
      isAnswered: true,
      score: isCorrect ? state.score + 1 : state.score,
    );
  }

  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      final locale = ref.read(localeProvider);
      final isEs = locale.languageCode == 'es';
      
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        isAnswered: false,
        resetSelected: true,
      );
      _generateOptions(isEs);
    }
  }
}

// Global Provider for the Trivia Game
final triviaProvider = NotifierProvider<TriviaNotifier, TriviaState>(
  TriviaNotifier.new,
);
