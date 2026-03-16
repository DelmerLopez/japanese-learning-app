# JLPT N5 Mastery - App Requirements

Based on the implemented features, here are the core requirements and functionalities of the application:

## 1. Non-functional requirements
- **Performance**: The app should be responsive and provide a smooth user experience.
- **Maintainability**: The app should be easy to maintain and modify. The app should use Feature-First folder structure
- **Scalability**: The app should be scalable to accommodate future features.
- **Internationalization**: The app should be easy to internationalize. The app should support english and spanish.

## 2. Functional requirements

### 1. General UI / UX
- **Theme & Styling**: The app should use a vibrant, modern UI with a dynamic gradient background (combining dark blues and purples `0xff0f0c29`, `0xff302b63`, `0xff24243e`).
- **Animations**: The app should have custom page transitions (slide up and fade in) when navigating between screens.
- **State Management**: The app should use `flutter_riverpod` for state management, specifically for the Trivia feature.

### 2. Home Screen
- The app should display the app title "JLPT N5 Mastery".
- The app should feature a central language icon with glowing effects.
- The app should show the following sections:
  - **"Learn Kanji" Button**: Navigates the user to the Kanji Explorer Screen.
  - **"Play Trivia" Button**: Navigates the user to the Trivia Screen.
  - **"Learn Vocabulary" Button**: Navigates the user to the Vocabulary Explorer Screen.
- The app should show a footer credit indicating "Vibecoded by Delmer Lopez".

### 3. Kanji Explorer Screen (`explore_screen.dart`)
The app should implement the following:
- **Interactive Carousel**: Displays the JLPT N5 Kanji in a horizontal, swipeable `PageView`.
- **Animations**: The central card is scaled up, while adjacent cards are scaled down to create a focused 3D carousel effect.
- **Kanji Card**: Each page displays a `KanjiCard` containing the kanji character and presumably its readings/meanings.
- **Navigation Controls**: 
  - A bottom navigation pill showing the current progress (e.g., "1 / 85").
  - "Previous" and "Next" arrow buttons to navigate through the kanji list manually.
- **Header**: Includes a back button to return to the Home Screen and a title "JLPT N5 Kanji".

### 4. Trivia Screen (`trivia_screen.dart`)
The app should implement the following:
- **Gameplay Mechanics**:
  - Displays a large target Kanji character in the center.
  - Provides a list of possible meanings (options) as clickable buttons.
- **Interactive Feedback**:
  - Upon selecting an option, the button changes color: Green if correct, Red if incorrect.
  - The game automatically advances to the next question after a 1.5-second delay to let the user see the correct answer.
- **Scoring & Completion**:
  - Tracks the user's score and current question index (e.g., "Q 1/10").
  - When all questions are answered, a summary dialog appears showing the final score with a trophy icon.
  - Features a "Return Home" button to exit the trivia.
- **State Handling**: The game state is reset if the user manually exits the screen via the back button.

### 5. Vocabulary Explorer Screen (`vocabulary_explorer_screen.dart`)
The app should implement the following:
- **Topic Menu**: The app should display a menu of topics to choose from.
- **Interactive Carousel**: The app should display the vocabulary words for the selected topic in a horizontal, swipeable `PageView`.
- **Animations**: The central card is scaled up, while adjacent cards are scaled down to create a focused 3D carousel effect.
- **Vocabulary Card**: Each page displays a `VocabularyCard` containing the vocabulary word and presumably its readings/meanings.
- **Navigation Controls**: 
  - A bottom navigation pill showing the current progress (e.g., "1 / 85").
  - "Previous" and "Next" arrow buttons to navigate through the vocabulary list manually.
- **Header**: Includes a back button to return to the Home Screen and a title "JLPT N5 Vocabulary".
