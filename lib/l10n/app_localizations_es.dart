// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Dominio JLPT N5';

  @override
  String get appSubtitle => 'Domina los 85 kanji esenciales.';

  @override
  String get startLearning => 'Empezar a Aprender';

  @override
  String get playTrivia => 'Jugar Trivia';

  @override
  String get learnVocabulary => 'Aprender Vocabulario';

  @override
  String get credits => 'Vibecoded por Delmer Lopez';

  @override
  String get kanjiExplorerTitle => 'Kanji JLPT N5';

  @override
  String triviaTitle(int current, int total) {
    return 'Trivia - P $current/$total';
  }

  @override
  String get triviaCompleteTitle => '¡Trivia Completada!';

  @override
  String scoreText(int score, int total) {
    return 'Tu Puntuación:\n$score / $total';
  }

  @override
  String get returnHome => 'Volver al Inicio';
}
