import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_cards/feats/cards/presentation/cards_screen/bloc/word_cards_bloc.dart';
import 'package:word_cards/generated/assets.gen.dart';

class WordCard extends StatelessWidget {
  const WordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Assets.ui.uiBlock.image(),
        Align(
          alignment: Alignment.center,
          child: BlocBuilder<WordCardsBloc, WordCardsState>(
            builder: (context, state) {
              return Column(
                children: [
                  const SizedBox(height: 25),
                  const Icon(Icons.door_back_door, size: 225, color: Colors.white),
                  const SizedBox(height: 25),
                  Text(
                    'text 1',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'text 2',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
