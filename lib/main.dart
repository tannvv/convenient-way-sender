import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:convenient_way_sender/app/app.dart';
import 'package:convenient_way_sender/app/config/build_config.dart';
import 'package:convenient_way_sender/app/config/environment.dart';
import 'package:convenient_way_sender/app/core/services/firebase_messaging_service.dart';
import 'package:convenient_way_sender/app/core/services/local_notification_service.dart';
import 'app/config/env_config.dart';
import 'app/config/firebase_options.dart';
import 'app/config/map_config.dart';

Future<void> main() async {
  Logger.root.onRecord.listen((LogRecord rec) {
    debugPrint('SignalR: ${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.setSettings(appVerificationDisabledForTesting: true);

  await dotenv.load(fileName: '.env');

  EnvConfig envConfig = EnvConfig(
      baseUrl: dotenv.get('BASE_URL_API'),
      baseUrlOrigin: dotenv.get('BASE_URL'));

  MapConfig mapConfig = MapConfig(
      mapboxUrlTemplate: dotenv.get('MAPBOX_URL_TEMPLATE'),
      mapboxAccessToken: dotenv.get('MAPBOX_ACCESS_TOKEN'),
      mapboxId: dotenv.get('MAPBOX_ID'));

  BuildConfig.instantiate(
      envType: Environment.DEVELOPMENT,
      envConfig: envConfig,
      mapConfig: mapConfig);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Intl.defaultLocale = 'vi_VN';
  initializeDateFormatting();
  LocalNotificationService.init();
  FirebaseMessagingService.init();
  runApp(const App());
}
