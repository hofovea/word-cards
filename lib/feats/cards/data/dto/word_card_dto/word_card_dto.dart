import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:word_cards/feats/cards/domain/entities/entities.dart' show WordCardEntity;

part 'word_card_dto.freezed.dart';

part 'word_card_dto.g.dart';

@freezed
class WordCardDto with _$WordCardDto {
  const WordCardDto._();

  const factory WordCardDto({
    @Default('') String cardId,
    @Default('') String word,
    @Default('') String translation,
    @Default('') String imageId,
  }) = _WordCardDto;

  factory WordCardDto.fromJson(Map<String, dynamic> json) => _$WordCardDtoFromJson(json);

  factory WordCardDto.fromRow({required List<Cell> row}) {
    return WordCardDto(
      cardId: row[0].value,
      word: row[1].value,
      translation: row[2].value,
      imageId: row[3].value,
    );
  }

  WordCardEntity toEntity(Map<String, String> imageUrlMap) {
    print('INSODE DTO MAPPER $imageUrlMap');
    return WordCardEntity(
      cardId: cardId,
      word: word,
      translation: translation,
      imageUrl: imageUrlMap[imageId] ?? '',
    );
  }
}
