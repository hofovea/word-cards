import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gsheets/gsheets.dart';
import 'package:word_cards/feats/cards/data/datasources/datasources.dart';
import 'package:word_cards/feats/cards/data/datasources/word_card_datasource/datasource_impl/spreadsheet_datasource.dart';
import 'package:word_cards/feats/cards/data/repository_impl/repository_impl.dart';
import 'package:word_cards/feats/cards/domain/repositories/repositories.dart';
import 'package:word_cards/feats/cards/domain/usecases/usecases.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  final credentials = '''{
    "type": "${dotenv.get('TYPE')}",
    "project_id": "${dotenv.get('PROJECT_ID')}",
    "private_key_id": "${dotenv.get('PRIVATE_KEY_ID')}",
    "private_key": "${dotenv.get('PRIVATE_KEY')}",
    "client_email": "${dotenv.get('CLIENT_EMAIL')}",
    "client_id": "${dotenv.get('CLIENT_ID')}",
    "auth_uri": "${dotenv.get('AUTH_URI')}",
    "token_uri": "${dotenv.get('TOKEN_URI')}",
    "auth_provider_x509_cert_url": "${dotenv.get('AUTH_PROVIDER_X509_CERT_URL')}",
    "client_x509_cert_url": "${dotenv.get('CLIENT_X509_CERT_URL')}",
    "universe_domain": "${dotenv.get('UNIVERSE_DOMAIN')}"
  }
  ''';
  final gSheets = GSheets(credentials);

  serviceLocator.registerSingletonAsync<Spreadsheet>(
    () async {
      return await gSheets.spreadsheet(
        dotenv.get('SPREADSHEET_ID'),
      );
    },
  );

  //usecases
  serviceLocator.registerLazySingleton<LoadWordCardList>(
    () => LoadWordCardList(repository: serviceLocator()),
  );

  //repositories
  serviceLocator.registerLazySingleton<IWordCardRepository>(
    () => WordCardRepositoryImpl(wordCardDatasource: serviceLocator()),
  );

  //datasources
  serviceLocator.registerLazySingleton<IWordCardDatasource>(
    () => SpreadsheetDatasource(spreadsheet: serviceLocator()),
  );
}
