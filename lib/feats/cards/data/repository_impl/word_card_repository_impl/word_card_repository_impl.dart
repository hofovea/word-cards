import 'package:fpdart/fpdart.dart';
import 'package:word_cards/core/data/exceptions/exceptions.dart';
import 'package:word_cards/core/domain/failures/failures.dart';
import 'package:word_cards/feats/cards/domain/entities/word_card_entity.dart';
import 'package:word_cards/feats/cards/data/datasources/datasources.dart' show IWordCardDatasource;
import 'package:word_cards/feats/cards/domain/repositories/repositories.dart'
    show IWordCardRepository;

class WordCardRepositoryImpl implements IWordCardRepository {
  final IWordCardDatasource _wordCardDatasource;

  WordCardRepositoryImpl({required IWordCardDatasource wordCardDatasource})
      : _wordCardDatasource = wordCardDatasource;

  @override
  Future<Either<Failure, List<WordCardEntity>>> loadWordCardsList() async {
    try {
      return Right(
        (await _wordCardDatasource.loadWordCardsList())
            .map(
              (dto) => dto.toEntity(),
            )
            .toList(),
      );
    } on CoreException catch (e) {
      switch (e) {
        case UnknownException():
          return Left(UnknownFailure());
      }
    }
  }
}
