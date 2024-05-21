import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_cards/feats/cards/presentation/cards_screen/bloc/word_cards_bloc.dart';
import 'package:word_cards/generated/assets.gen.dart';

class WordCard extends StatefulWidget {
  const WordCard({super.key});

  @override
  State<WordCard> createState() => _WordCardState();
}

class _WordCardState extends State<WordCard> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.ui.uiBlock.image(),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: BlocConsumer<WordCardsBloc, WordCardsState>(
              listener: (BuildContext context, WordCardsState state) {
                if (state is CardChangedState) {
                  _controller.reset();
                  _controller.forward();
                }
              },
              builder: (context, state) {
                return switch (state) {
                  InitialState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  CardChangedState() => FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1).animate(
                        CurvedAnimation(parent: _controller, curve: Curves.easeIn),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: FractionallySizedBox(
                                heightFactor: 0.8,
                                widthFactor: 0.8,
                                child: Image.network(
                                  state.wordCardList[state.currentCardIndex].imageUrl,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60),
                          Text(
                            state.wordCardList[state.currentCardIndex].word,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            state.wordCardList[state.currentCardIndex].translation,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                    ),
                  NoCardsState() => const Center(
                      child: Icon(
                        Icons.clear,
                        size: 200,
                        color: Colors.white,
                      ),
                    ),
                };
              },
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
