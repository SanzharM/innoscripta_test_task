import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innoscripta_test_task/src/application.dart';
import 'package:innoscripta_test_task/src/core/constants/constants.dart';
import 'package:innoscripta_test_task/src/core/storage/hive_storage.dart';
import 'package:innoscripta_test_task/src/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initialize();
  await di.sl<HiveStorage>().initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarColor: AppColors.transparent,
    ),
  );

  const app = Application();
  runApp(app);
}
