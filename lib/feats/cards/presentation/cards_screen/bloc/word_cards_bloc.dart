import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'word_cards_event.dart';

part 'word_cards_state.dart';

part 'word_cards_bloc.freezed.dart';

class WordCardsBloc extends Bloc<WordCardsEvent, WordCardsState> {
  WordCardsBloc() : super(const WordCardsState.cardChanged()) {
    on<WordCardsEvent>(
      (event, emit) {
        event.when(
          next: () {},
          back: () {},
        );
      },
    );
  }
}
