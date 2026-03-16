// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'JLPT N5 Mastery';

  @override
  String get appSubtitle => 'Master the 85 essential kanji.';

  @override
  String get startLearning => 'Start Learning';

  @override
  String get playTrivia => 'Play Trivia';

  @override
  String get learnVocabulary => 'Learn Vocabulary';

  @override
  String get credits => 'Vibecoded by Delmer Lopez';

  @override
  String get kanjiExplorerTitle => 'JLPT N5 Kanji';

  @override
  String triviaTitle(int current, int total) {
    return 'Trivia - Q $current/$total';
  }

  @override
  String get triviaCompleteTitle => 'Trivia Complete!';

  @override
  String scoreText(int score, int total) {
    return 'Your Score:\n$score / $total';
  }

  @override
  String get returnHome => 'Return Home';
}
