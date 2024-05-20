import 'package:fpdart/fpdart.dart';
import 'package:word_cards/core/domain/failures/failures.dart';
import 'package:word_cards/feats/cards/domain/entities/entities.dart';

abstract interface class IWordCardRepository {
  Future<Either<Failure, List<WordCardEntity>>> loadWordCardsList();
}
