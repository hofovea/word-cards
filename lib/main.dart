import 'package:flutter/material.dart';
import 'package:word_cards/app/app.dart';

void main() {
  runApp(const WordCardsApp());
}

class WordCardsApp extends StatelessWidget {
  const WordCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
