import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:word_cards/core/domain/failures/failures.dart';
import 'package:word_cards/feats/cards/domain/entities/entities.dart';
import 'package:word_cards/feats/cards/domain/usecases/usecases.dart' show LoadWordCardList;

part 'word_cards_event.dart';

part 'word_cards_state.dart';

class WordCardsBloc extends Bloc<WordCardsEvent, WordCardsState> {
  final LoadWordCardList _loadWordCardList = GetIt.I.get();

  WordCardsBloc() : super(InitialState()) {
    on<WordCardsEvent>(
      (event, emit) async {
        switch (event) {
          case LoadCardsEvent():
            final result = await _loadWordCardList();
            result.fold(
              (failure) {
                switch (failure) {
                  case UnknownFailure():
                    print('INSIDE BLOC: Failure');
                }
              },
              (wordCardList) {
                for (final a in wordCardList) {
                  print('INSODE BLOC: ${a.word}');
                  print('INSODE BLOC: ${a.imageUrl}');
                }
                if (wordCardList.isEmpty) {
                  emit(NoCardsState());
                }
                emit(
                  CardChangedState(
                    currentCardIndex: 0,
                    wordCardList: wordCardList,
                  ),
                );
              },
            );
          case NextEvent():
            print('next was pressed');
            switch (state) {
              case InitialState():
                emit(
                  CardChangedState(
                    currentCardIndex: 0,
                    wordCardList: state.wordCardList,
                  ),
                );
              case CardChangedState():
                final nextIndex =
                    ((state as CardChangedState).currentCardIndex + 1) % state.wordCardList.length;
                emit(
                  CardChangedState(
                    currentCardIndex: nextIndex,
                    wordCardList: state.wordCardList,
                  ),
                );
              case NoCardsState():
              // emit(NoCardsState(wordCardList: state.wordCardList));
            }
          case BackEvent():
            print('back was pressed');
            switch (state) {
              case InitialState():
                emit(
                  CardChangedState(
                    currentCardIndex: 0,
                    wordCardList: state.wordCardList,
                  ),
                );
              case CardChangedState():
                final nextIndex =
                    ((state as CardChangedState).currentCardIndex - 1) % state.wordCardList.length;
                emit(
                  CardChangedState(
                    currentCardIndex: nextIndex,
                    wordCardList: state.wordCardList,
                  ),
                );
              case NoCardsState():
              // emit(NoCardsState(wordCardList: state.wordCardList));
            }
        }
      },
    );
  }
}
