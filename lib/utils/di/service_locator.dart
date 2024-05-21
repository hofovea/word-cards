import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gsheets/gsheets.dart';
import 'package:word_cards/feats/cards/data/datasources/datasources.dart';
import 'package:word_cards/feats/cards/data/repository_impl/repository_impl.dart';
import 'package:word_cards/feats/cards/domain/repositories/repositories.dart';
import 'package:word_cards/feats/cards/domain/usecases/usecases.dart';
import 'package:word_cards/utils/constants/constants.dart' as constants;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 5),
  ));
  _setupServiceLocator();
}

void _setupServiceLocator() {
  final credentials = '''{
    "type": "${dotenv.get(constants.TYPE)}",
    "project_id": "${dotenv.get(constants.PROJECT_ID)}",
    "private_key_id": "${dotenv.get(constants.PRIVATE_KEY_ID)}",
    "private_key": "${dotenv.get(constants.PRIVATE_KEY)}",
    "client_email": "${dotenv.get(constants.CLIENT_EMAIL)}",
    "client_id": "${dotenv.get(constants.CLIENT_ID)}",
    "auth_uri": "${dotenv.get(constants.AUTH_URI)}",
    "token_uri": "${dotenv.get(constants.TOKEN_URI)}",
    "auth_provider_x509_cert_url": "${dotenv.get(constants.AUTH_PROVIDER_X509_CERT_URL)}",
    "client_x509_cert_url": "${dotenv.get(constants.CLIENT_X509_CERT_URL)}",
    "universe_domain": "${dotenv.get(constants.UNIVERSE_DOMAIN)}"
  }
  ''';
  final gSheets = GSheets(credentials);

  serviceLocator.registerLazySingletonAsync<Spreadsheet>(
    () async {
      return await gSheets.spreadsheet(
        dotenv.get(constants.SPREADSHEET_ID),
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

  // serviceLocator.registerLazySingleton<IWordCardDatasource>(
  //   () => SpreadsheetDatasource(spreadsheet: serviceLocator()),
  // );

  serviceLocator.registerLazySingleton<IWordCardDatasource>(
    () => JsonDatasource(),
  );
}
