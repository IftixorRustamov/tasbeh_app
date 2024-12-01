import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasbeh/data/models/counter_history.dart';
import 'package:tasbeh/tasbeh_app.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CounterHistoryAdapter());
  await Hive.openBox("boxCounter");
  await Hive.openBox<CounterHistory>('historyBox');
  runApp(const TasbehApp());
}
