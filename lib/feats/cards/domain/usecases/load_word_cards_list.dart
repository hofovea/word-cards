import 'package:fpdart/fpdart.dart';
import 'package:word_cards/core/domain/failures/failures.dart';
import 'package:word_cards/feats/cards/domain/entities/word_card_entity.dart';
import 'package:word_cards/feats/cards/domain/repositories/repositories.dart'
    show IWordCardRepository;

class LoadWordCardList {
  final IWordCardRepository _repository;

  LoadWordCardList({required IWordCardRepository repository}) : _repository = repository;

  Future<Either<Failure, List<WordCardEntity>>> call() async =>
      await _repository.loadWordCardsList();
}
