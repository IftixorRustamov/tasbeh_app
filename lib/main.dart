import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasbeh/data/models/counter_history.dart';
import 'package:tasbeh/tasbeh_app.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CounterHistoryAdapter());
  await Hive.openBox("boxCounter");
  await Hive.openBox<CounterHistory>('historyBox');
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('uz'),
      ],
      child: const TasbehApp(),
    ),
  );
}
