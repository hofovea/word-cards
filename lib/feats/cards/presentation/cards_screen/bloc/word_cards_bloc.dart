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
            emit(InitialState());
            final result = await _loadWordCardList();
            result.fold(
              (failure) {
                switch (failure) {
                  case UnknownFailure():
                    emit(FailedLoadState());
                }
              },
              (wordCardList) {
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
            if (state is CardChangedState) {
              final nextIndex =
                  ((state as CardChangedState).currentCardIndex + 1) % state.wordCardList.length;
              emit(
                CardChangedState(
                  currentCardIndex: nextIndex,
                  wordCardList: state.wordCardList,
                ),
              );
            }

          case BackEvent():
            if (state is CardChangedState) {
              final nextIndex =
                  ((state as CardChangedState).currentCardIndex - 1) % state.wordCardList.length;
              emit(
                CardChangedState(
                  currentCardIndex: nextIndex,
                  wordCardList: state.wordCardList,
                ),
              );
            }
          case NoConnectionEvent():
            emit(NoConnectionState());
          case HasConnectionEvent():
            add(LoadCardsEvent());
        }
      },
    );
  }
}
