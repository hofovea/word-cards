part of 'word_cards_bloc.dart';

sealed class WordCardsEvent {}

class LoadCardsEvent extends WordCardsEvent {}

class NextEvent extends WordCardsEvent {}

class BackEvent extends WordCardsEvent {}

class NoConnectionEvent extends WordCardsEvent {}

class HasConnectionEvent extends WordCardsEvent {}
