import 'package:flutter/material.dart';
import '../../core/models/vocabulary.dart';
import 'widgets/vocabulary_card.dart';

class VocabularyExplorerScreen extends StatefulWidget {
  final VocabularyTopic topic;

  const VocabularyExplorerScreen({super.key, required this.topic});

  @override
  State<VocabularyExplorerScreen> createState() => _VocabularyExplorerScreenState();
}

class _VocabularyExplorerScreenState extends State<VocabularyExplorerScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final topicName = languageCode == 'es' ? widget.topic.nameEs : widget.topic.nameEn;
    final vocabList = widget.topic.words;

    return Scaffold(
      body: Stack(
        children: [
          // Dynamic gradient background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff0f0c29),
                    Color(0xff302b63),
                    Color(0xff24243e),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                        // Return cleanly
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        topicName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                // Carousel
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: vocabList.length,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          } else {
                            value = index == 0 ? 1.0 : 0.7;
                          }
                          return Center(
                            child: Transform.scale(
                              scale: Curves.easeInOut.transform(value),
                              child: Opacity(
                                opacity: value.clamp(0.5, 1.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 40.0,
                                    horizontal: 10.0,
                                  ),
                                  child: VocabularyCard(
                                    vocabulary: vocabList[index],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Navigation Controls
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 24.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Previous Button
                      IconButton(
                        onPressed:
                            _currentIndex > 0
                                ? () {
                                    _pageController.previousPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                : null,
                        icon: const Icon(Icons.arrow_back_rounded),
                        color: Colors.white,
                        disabledColor: Colors.white24,
                        iconSize: 32,
                      ),

                      // Progress Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          '${_currentIndex + 1} / ${vocabList.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),

                      // Next Button
                      IconButton(
                        onPressed:
                            _currentIndex < vocabList.length - 1
                                ? () {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                : null,
                        icon: const Icon(Icons.arrow_forward_rounded),
                        color: Colors.white,
                        disabledColor: Colors.white24,
                        iconSize: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
