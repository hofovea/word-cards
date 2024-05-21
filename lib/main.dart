import 'package:flutter/material.dart';
import 'package:word_cards/app/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:word_cards/utils/di/service_locator.dart' as service_locator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  service_locator.setupServiceLocator();
  await service_locator.serviceLocator.allReady();

  runApp(const WordCardsApp());
}
