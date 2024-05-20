import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_cards/feats/cards/presentation/cards_screen/bloc/word_cards_bloc.dart';
import 'widgets/widgets.dart';

@RoutePage()
class CardsScreen extends StatelessWidget implements AutoRouteWrapper {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 35.0, bottom: 50.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const WordCard(),
            const Spacer(),
            Row(
              children: [
                Flexible(
                  child: AssetButton.back(
                    onClick: () {
                      BlocProvider.of<WordCardsBloc>(context).add(const WordCardsEvent.back());
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: AssetButton.next(
                    onClick: () {
                      BlocProvider.of<WordCardsBloc>(context).add(const WordCardsEvent.next());
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => WordCardsBloc(),
      child: this, // this as the child Important!
    );
  }
}
