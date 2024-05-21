part of 'word_cards_bloc.dart';

sealed class WordCardsState extends Equatable {
  final List<WordCardEntity> wordCardList;

  const WordCardsState({required this.wordCardList});
}

class InitialState extends WordCardsState {
  InitialState() : super(wordCardList: []);

  @override
  List<Object?> get props => [wordCardList];
}

class NoCardsState extends WordCardsState {
  NoCardsState() : super(wordCardList: []);

  @override
  List<Object?> get props => [wordCardList];
}

class CardChangedState extends WordCardsState {
  final int currentCardIndex;

  const CardChangedState({required this.currentCardIndex, required super.wordCardList});

  @override
  List<Object?> get props => [currentCardIndex, wordCardList];
}
