import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(FlashcardApp());
}

class FlashcardApp extends StatelessWidget {
  final List<Flashcard> flashcards = [
    Flashcard(
      frenchWord: 'Bonjour',
      englishWord: 'Hello',
      gender: 'Masculine',
      pictureUrl: 'https://img.freepik.com/premium-vector/bonjour-paris-phrase-vector-lettering-calligraphy-brush-chalkboard_83277-10408.jpg?w=2000',
      exampleSentence: 'Bonjour, comment ça va?',
    ),
    Flashcard(
      frenchWord: 'Chien',
      englishWord: 'Dog',
      gender: 'Masculine',
      pictureUrl: 'https://sieupet.com/sites/default/files/pitbull3_0.jpg',
      exampleSentence: 'J\'aime mon chien.',
    ),
    // Add more flashcards here
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('French Flashcards'),
        ),
        body: Center(
          child: FlashcardList(flashcards: flashcards),
        ),
      ),
    );
  }
}

class FlashcardList extends StatefulWidget {
  final List<Flashcard> flashcards;

  FlashcardList({required this.flashcards});

  @override
  State<FlashcardList> createState() => _FlashcardListState();
}

class _FlashcardListState extends State<FlashcardList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              // Swipe right (mark as remembered)
              setState(() {
                currentIndex = (currentIndex + 1) % widget.flashcards.length;
              });
            } else {
              // Swipe left (mark as not remembered)
              setState(() {
                currentIndex = Random().nextInt(widget.flashcards.length);
              });
            }
          },
          child: FlashcardWidget(flashcard: widget.flashcards[currentIndex]),
        ),
      ],
    );
  }
}

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;

  const FlashcardWidget({super.key, required this.flashcard});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('French Word: ${flashcard.frenchWord}'),
          Text('English Word: ${flashcard.englishWord}'),
          Text('Gender: ${flashcard.gender}'),
          Text('Example Sentence: ${flashcard.exampleSentence}'),
        ],
      ),
    );
  }
}

class Flashcard {
  final String frenchWord;
  final String englishWord;
  final String gender;
  final String pictureUrl;
  final String exampleSentence;

  Flashcard({
    required this.frenchWord,
    required this.englishWord,
    required this.gender,
    required this.pictureUrl,
    required this.exampleSentence,
  });
}