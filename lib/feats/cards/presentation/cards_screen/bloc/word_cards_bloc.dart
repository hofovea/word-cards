import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:word_cards/core/domain/failures/failures.dart';
import 'package:word_cards/feats/cards/domain/usecases/usecases.dart' show LoadWordCardList;

part 'word_cards_event.dart';

part 'word_cards_state.dart';

part 'word_cards_bloc.freezed.dart';

class WordCardsBloc extends Bloc<WordCardsEvent, WordCardsState> {
  final LoadWordCardList _loadWordCardList = GetIt.I.get();

  WordCardsBloc() : super(const WordCardsState.cardChanged()) {
    on<WordCardsEvent>(
      (event, emit) async {
        await event.when(
          next: () async {
            final result = await _loadWordCardList();
            result.fold(
              (failure) {
                switch (failure) {
                  case UnknownFailure():
                  // TODO: Handle this case.
                }
              },
              (wordCardList) {
                print('INSODE BLOC: ${wordCardList}');
              },
            );
            print('next was pressed');
          },
          back: () async {
            print('back was pressed');
          },
        );
      },
    );
  }
}
