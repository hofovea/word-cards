import 'package:gsheets/gsheets.dart';
import 'package:word_cards/core/data/exceptions/exceptions.dart';
import 'package:word_cards/feats/cards/data/datasources/word_card_datasource/word_card_datasource.dart';
import 'package:word_cards/feats/cards/data/dto/dtos.dart';

class SpreadsheetDatasource implements IWordCardDatasource {
  final Spreadsheet _spreadsheet;

  SpreadsheetDatasource({required Spreadsheet spreadsheet}) : _spreadsheet = spreadsheet;

  @override
  Future<List<WordCardDto>> loadWordCardsList() async {
    try {
      final rows = await _spreadsheet.sheets.first.cells.allRows()
        ..removeAt(0);
      return rows.map((row) => WordCardDto.fromRow(row: row)).toList();
    } on CoreException catch (e) {
      throw UnknownException(e.message);
    }
  }

  // @override
  // Future<List<WordCardDto>> loadFromFromJsonList() async {
  //   try {
  //     final response = await http.get(Uri.parse(dotenv.get(constants.WEB_APP_URL)));
  //     if (response.statusCode == HttpStatus.ok) {
  //       final jsonDataList = jsonDecode(response.body) as List<dynamic>;
  //       final r = jsonDataList.map((jsonItem) => WordCardDto.fromJson(jsonItem)).toList();
  //       return jsonDataList.map((jsonItem) => WordCardDto.fromJson(jsonItem)).toList();
  //     } else {
  //       return [];
  //     }
  //   } on CoreException catch (e) {
  //     throw UnknownException(e.message);
  //   }
  // }
}
