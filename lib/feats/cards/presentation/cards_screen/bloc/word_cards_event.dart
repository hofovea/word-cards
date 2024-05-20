part of 'word_cards_bloc.dart';

@freezed
class WordCardsEvent with _$WordCardsEvent {
  const factory WordCardsEvent.next() = _Next;
  const factory WordCardsEvent.back() = _Back;
}


