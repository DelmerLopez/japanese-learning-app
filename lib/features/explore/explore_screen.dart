import 'package:flutter/material.dart';
import '../../core/data/kanji_data.dart';
import 'widgets/kanji_card.dart';

class KanjiExplorerScreen extends StatefulWidget {
  const KanjiExplorerScreen({super.key});

  @override
  State<KanjiExplorerScreen> createState() => _KanjiExplorerScreenState();
}

class _KanjiExplorerScreenState extends State<KanjiExplorerScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.75);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'JLPT N5 Kanji',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
          ),
        ),
        centerTitle: true,
      ),
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
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          Center(
            child: SizedBox(
              height: 450,
              child: PageView.builder(
                controller: _pageController,
                itemCount: n5KanjiList.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.2)).clamp(0.0, 1.0);
                      } else {
                        // fallback before first layout
                        value = index == 0 ? 1.0 : 0.8;
                      }

                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 450,
                          width: Curves.easeOut.transform(value) * 350,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      child: KanjiCard(kanji: n5KanjiList[index]),
                    ),
                  );
                },
              ),
            ),
          ),

          // Navigation counter
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_currentPage > 0) {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${_currentPage + 1} / ${n5KanjiList.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_currentPage < n5KanjiList.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                      },
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
