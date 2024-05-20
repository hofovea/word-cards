import 'package:word_cards/feats/cards/data/dto/dtos.dart' show WordCardDto;

abstract interface class IWordCardDatasource {
  Future<List<WordCardDto>> loadWordCardsList();
}
