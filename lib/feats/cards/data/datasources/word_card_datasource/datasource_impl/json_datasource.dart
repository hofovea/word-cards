import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:word_cards/core/data/exceptions/exceptions.dart';
import 'package:word_cards/feats/cards/data/datasources/word_card_datasource/word_card_datasource.dart';
import 'package:word_cards/feats/cards/data/dto/dtos.dart';
import 'package:http/http.dart' as http;
import 'package:word_cards/utils/constants/constants.dart' as constants;

class JsonDatasource implements IWordCardDatasource {
  @override
  Future<List<WordCardDto>> loadWordCardsList() async {
    try {
      final response = await http.get(Uri.parse(dotenv.get(constants.WEB_APP_URL)));
      if (response.statusCode == HttpStatus.ok) {
        final jsonDataList = jsonDecode(response.body) as List<dynamic>;
        return jsonDataList.map((jsonItem) => WordCardDto.fromJson(jsonItem)).toList();
      } else {
        return [];
      }
    } on CoreException catch (e) {
      throw UnknownException(e.message);
    }
  }
}
