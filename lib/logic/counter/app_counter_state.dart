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

class AppCounterValidationFailed extends AppCounterState {
  final String? startValueError;
  final String? remainderValueError;
  final String? targetValueError;

  AppCounterValidationFailed(this.startValueError, this.remainderValueError, this.targetValueError);

  @override
  List<Object?> get props => [startValueError, remainderValueError, targetValueError];
}


