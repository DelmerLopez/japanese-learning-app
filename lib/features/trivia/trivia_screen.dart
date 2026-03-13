import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/trivia_provider.dart';

class TriviaScreen extends ConsumerWidget {
  const TriviaScreen({super.key});

  void _showScoreDialog(BuildContext context, int score, int total) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff302b63),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Trivia Complete!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, color: Colors.amber, size: 80),
            const SizedBox(height: 20),
            Text(
              'Your Score:\n$score / $total',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent.shade200,
                  Colors.purpleAccent.shade400,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Return Home',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triviaState = ref.watch(triviaProvider);
    final triviaNotifier = ref.read(triviaProvider.notifier);

    // Initial Loading State Protection
    if (triviaState.questions.isEmpty) {
      return const Scaffold(backgroundColor: Color(0xff0f0c29));
    }

    final curKanji = triviaState.currentKanji;

    ref.listen<TriviaState>(triviaProvider, (previous, next) {
      if (previous != null && !previous.isAnswered && next.isAnswered) {
        // Delay to show answer before transitioning to next question or end
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (!context.mounted) return;
          if (next.isGameOver) {
            _showScoreDialog(context, next.score, next.questions.length);
          } else {
            triviaNotifier.nextQuestion();
          }
        });
      }
    });

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Restart game context when exiting so it's fresh next time
            triviaNotifier.restartGame();
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Trivia - Q ${triviaState.currentIndex + 1}/${triviaState.questions.length}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff0f0c29),
                    Color(0xff302b63),
                    Color(0xff24243e),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withValues(alpha: 0.05),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          curKanji.character,
                          style: const TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(color: Colors.black54, blurRadius: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: triviaState.currentOptions.map((option) {
                          bool isCorrectOption = option == curKanji.meaning;
                          bool isSelected =
                              option == triviaState.selectedOption;

                          Color buttonColor = Colors.white.withValues(
                            alpha: 0.05,
                          );
                          Color borderColor = Colors.white.withValues(
                            alpha: 0.1,
                          );

                          if (triviaState.isAnswered) {
                            if (isCorrectOption) {
                              buttonColor = Colors.green.withValues(alpha: 0.4);
                              borderColor = Colors.greenAccent;
                            } else if (isSelected && !isCorrectOption) {
                              buttonColor = Colors.red.withValues(alpha: 0.4);
                              borderColor = Colors.redAccent;
                            }
                          }

                          return MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () => triviaNotifier.selectOption(option),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: double.infinity,
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    option,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
