import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/fpdart.dart';
import 'package:word_cards/core/data/exceptions/exceptions.dart';
import 'package:word_cards/core/domain/failures/failures.dart';
import 'package:word_cards/feats/cards/domain/entities/word_card_entity.dart';
import 'package:word_cards/feats/cards/data/datasources/datasources.dart' show IWordCardDatasource;
import 'package:word_cards/feats/cards/domain/repositories/repositories.dart'
    show IWordCardRepository;

class WordCardRepositoryImpl implements IWordCardRepository {
  final imageBucketRef = FirebaseStorage.instance.ref().child('Cards');
  final IWordCardDatasource _wordCardDatasource;

  WordCardRepositoryImpl({required IWordCardDatasource wordCardDatasource})
      : _wordCardDatasource = wordCardDatasource;

  @override
  Future<Either<Failure, List<WordCardEntity>>> loadWordCardsList() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      final orderConfig = remoteConfig.getString('cards_order');
      final List<String> order =
          (jsonDecode(orderConfig) as List<dynamic>).cast<String>();

      final referenceList = (await imageBucketRef.listAll()).items;
      final imageUrlMap = <String, String>{};
      for (final reference in referenceList) {
        imageUrlMap[reference.name.split('.').first] = await reference.getDownloadURL();
      }

      final unsortedDtoList = await _wordCardDatasource.loadWordCardsList();

      return Right(
        order
            .map((cardId) => unsortedDtoList
                .firstWhere(
                  (dto) => cardId == dto.cardId,
                )
                .toEntity(imageUrlMap))
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
