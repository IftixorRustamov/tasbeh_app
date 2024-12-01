import 'package:hive/hive.dart';

part 'counter_history.g.dart';

@HiveType(typeId: 1)
class CounterHistory {
  @HiveField(1)
  int counter;

  @HiveField(2)
  DateTime countedDate;

  CounterHistory({required this.counter, required this.countedDate});
}
