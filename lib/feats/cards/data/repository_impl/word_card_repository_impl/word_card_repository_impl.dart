import 'package:firebase_storage/firebase_storage.dart';
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
      final referenceList = (await FirebaseStorage.instance.ref().child('Cards').listAll()).items;
      final imageUrlMap = <String, String>{};
      for (final reference in referenceList) {
        imageUrlMap[reference.name.split('.').first] = await reference.getDownloadURL();
      }
      return Right(
        (await _wordCardDatasource.loadWordCardsList()).map(
          (dto) {
            return dto.toEntity(imageUrlMap);
          },
        ).toList(),
      );
    } on CoreException catch (e) {
      switch (e) {
        case UnknownException():
          return Left(UnknownFailure());
      }
    }
  }
}
