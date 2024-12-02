import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:tasbeh/data/models/counter_history.dart';

part 'app_counter_state.dart';

class AppCounterCubit extends Cubit<AppCounterState> {
  AppCounterCubit() : super(AppCounterInitial(0, true, true, 33, 1000)) {
    loadRemainderData();
  }

  final AudioPlayer _player = AudioPlayer();
  final counterBox = Hive.box('boxCounter');
  final historyBox = Hive.box<CounterHistory>("historyBox");

  int get currentCounter => (state as AppCounterInitial).counter;

  bool get isVibrated => (state as AppCounterInitial).isVibrated;

  bool get isPlayed => (state as AppCounterInitial).isPlayed;

  int get currentRemainder => (state as AppCounterInitial).remainderValue;

  int get currentTarget => (state as AppCounterInitial).targetValue;

  String? startValueError;
  String? remainderValueError;
  String? targetValueError;

  // increment counter
  void increment() async {
    checkAndResetDailyCounter();
    if (currentCounter < currentTarget) {
      final newCounter = currentCounter + 1;
      counterBox.put('startValue', newCounter);
      emit(AppCounterInitial(
          newCounter, isVibrated, isPlayed, currentRemainder, currentTarget));
    }
    if (isVibrated) vibrateMyPhone();
    if (isPlayed) playAudio();
  }

  // vibrate phone when toggled
  Future<void> vibrateMyPhone() async {
    final canVibrate = await Haptics.canVibrate();
    if (canVibrate) {
      await Haptics.vibrate(HapticsType.medium);
    }
  }

  void toggleVibration() {
    final newVibrationStatus = !isVibrated;
    counterBox.put('isVibrated', newVibrationStatus);
    emit(AppCounterInitial(currentCounter, newVibrationStatus, isPlayed,
        currentRemainder, currentTarget));
  }

  // play audio when toggled
  void playAudio() async {
    if (isPlayed) {
      await _player.stop();
      await _player.play(AssetSource("audio/ipad_click-99325.mp3"));
    }
  }

  void togglePlayer() {
    final newPlayerStatus = !isPlayed;
    counterBox.put('isPlayed', newPlayerStatus);
    emit(AppCounterInitial(currentCounter, isVibrated, newPlayerStatus,
        currentRemainder, currentTarget));
  }

  // reset counter
  void reset() {
    counterBox.put('startValue', 0);
    emit(AppCounterInitial(
        0, isVibrated, isPlayed, currentRemainder, currentTarget));
  }

  // save to CounterHistory model
  void saveToHistory(int count) {
    historyBox.add(CounterHistory(counter: count, countedDate: DateTime.now()));
  }

  Future<void> checkAndResetDailyCounter() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastSavedDate = counterBox.get('lastSavedDate', defaultValue: '');
    final lastCount = counterBox.get('startValue', defaultValue: 0);

    // If it's a new day, save last count to history and reset the counter
    if (lastSavedDate != today) {
      if (lastCount > 0) {
       saveToHistory(lastCount);
      }
      await counterBox.put('startValue', 0); // Reset counter
      await counterBox.put('lastSavedDate', today); // Update saved date
    }
  }

  // save data
  Future<void> saveRemainderData(
      String startValue, String remainderValue, String targetValue) async {
    final start = int.parse(startValue);
    final remainder = int.parse(remainderValue);
    final target = int.parse(targetValue);
    try {
      if (start < 0 || remainder <= 0 || target <= 0 || start >= target) {
        throw Exception("Invalid input values");
      }

      counterBox.put("startValue", start);
      counterBox.put("remainderValue", remainder);
      counterBox.put("targetValue", target);

      emit(AppCounterInitial(start, isVibrated, isPlayed, remainder, target));
    } catch (e) {
      emit(
        AppCounterValidationFailed(
            start < 0 ? "Invalid start value" : null,
            remainder <= 0 ? "Invalid remainder value" : null,
            target <= 0 || start >= target ? "Invalid target value" : null),
      );
    }
  }

  // load data
  void loadRemainderData() async {
    final startCache = counterBox.get('startValue', defaultValue: 0);
    final remainderCache = counterBox.get("remainderValue", defaultValue: 33);
    final targetCache = counterBox.get('targetValue', defaultValue: 1000);
    emit(AppCounterInitial(
        startCache, isVibrated, isPlayed, remainderCache, targetCache));
  }
}
