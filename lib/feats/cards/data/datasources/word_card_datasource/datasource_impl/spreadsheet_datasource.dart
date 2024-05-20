import 'package:get_it/get_it.dart';
import 'package:gsheets/gsheets.dart';
import 'package:word_cards/feats/cards/data/datasources/word_card_datasource/word_card_datasource.dart';
import 'package:word_cards/feats/cards/data/dto/dtos.dart';
import 'package:collection/collection.dart';

class SpreadsheetDatasource implements IWordCardDatasource {
  final Spreadsheet _spreadsheet;

  SpreadsheetDatasource({required Spreadsheet spreadsheet}) : _spreadsheet = spreadsheet;

  @override
  Future<List<WordCardDto>> loadWordCardsList() async {
    final rows = await _spreadsheet.sheets.first.cells.allRows()
      ..removeAt(0);
    final r = rows.map(
      (row) => WordCardDto.fromRow(row: row),
    ).toList();
    print(r);
    return r;
  }
}
