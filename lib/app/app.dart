import 'package:flutter/material.dart';
import 'package:word_cards/utils/router/router.dart';

class WordCardsApp extends StatelessWidget {
  const WordCardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MaterialApp.router(
      routerConfig: appRouter.config(),
    );
  }
}
