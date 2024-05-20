import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gsheets/gsheets.dart';
import 'package:word_cards/core/domain/dto/dto_interface.dart';
import 'package:word_cards/feats/cards/domain/entities/entities.dart' show WordCardEntity;

part 'word_card_dto.freezed.dart';

part 'word_card_dto.g.dart';

@freezed
class WordCardDto with _$WordCardDto implements IDto<WordCardEntity> {
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

  @override
  toEntity() => WordCardEntity(
        cardId: cardId,
        word: word,
        translation: translation,
        imageId: imageId,
      );
}
