part of 'app_counter_cubit.dart';

@immutable
sealed class AppCounterState extends Equatable {}

final class AppCounterInitial extends AppCounterState {
  final int counter;
  final bool isVibrated;
  final bool isPlayed;
  final int remainderValue;
  final int targetValue;

  AppCounterInitial(this.counter, this.isVibrated, this.isPlayed,
      this.remainderValue, this.targetValue);

  @override
  List<Object?> get props => [counter, isVibrated, isPlayed, remainderValue, targetValue];
}
