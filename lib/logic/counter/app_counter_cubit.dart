import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_counter_state.dart';

class AppCounterCubit extends Cubit<AppCounterState> {
  AppCounterCubit() : super(AppCounterInitial(0, true, true, 33, 1000)) {
    loadRemainderData();
  }

  final AudioPlayer _player = AudioPlayer();

  int get currentCounter => (state as AppCounterInitial).counter;

  bool get isVibrated => (state as AppCounterInitial).isVibrated;

  bool get isPlayed => (state as AppCounterInitial).isPlayed;

  int get currentRemainder => (state as AppCounterInitial).remainderValue;

  int get currentTarget => (state as AppCounterInitial).targetValue;

  String? startValueError;
  String? remainderValueError;
  String? targetValueError;

  void increment() async {
    if (currentCounter < currentTarget) {
      emit(AppCounterInitial(currentCounter + 1, isVibrated, isPlayed,
          currentRemainder, currentTarget));
    }
    await vibrateMyPhone();
    playAudio();
  }

  Future<void> vibrateMyPhone() async {
    final canVibrate = await Haptics.canVibrate();
    if (canVibrate && isVibrated) {
      await Haptics.vibrate(HapticsType.medium);
    }
  }

  void playAudio() async {
    if (isPlayed) {
      await _player.stop();
      await _player.play(AssetSource("audio/ipad_click-99325.mp3"));
    }
  }

  void toggleVibration() {
    emit(AppCounterInitial(currentCounter, !isVibrated, isPlayed,
        currentRemainder, currentTarget));
  }

  void togglePlayer() {
    emit(AppCounterInitial(currentCounter, isVibrated, !isPlayed,
        currentRemainder, currentTarget));
  }

  void reset() {
    emit(AppCounterInitial(
        0, isVibrated, isPlayed, currentRemainder, currentTarget));
  }

  Future<void> saveRemainderData(
      String startValue, String remainderValue, String targetValue) async {
    startValueError = null;
    remainderValueError = null;
    targetValueError = null;

    if (int.tryParse(startValue) == null || int.parse(startValue) < 0) {
      startValueError = "Invalid start value";
    }
    if (int.tryParse(remainderValue) == null ||
        int.parse(remainderValue) <= 0) {
      remainderValueError = "Invalid remainder value";
    }
    if (int.tryParse(targetValue) == null ||
        int.parse(targetValue) <= 0 ||
        int.parse(startValue) >= int.parse(targetValue)) {
      targetValueError = "Invalid target value";
    }

    if (startValueError != null ||
        remainderValueError != null ||
        targetValueError != null) {
      emit(AppCounterValidationFailed(
          startValueError, remainderValueError, targetValueError));
    } else {
      final start = int.parse(startValue);
      final remainder = int.parse(remainderValue);
      final target = int.parse(targetValue);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("startValue", start);
      await prefs.setInt("remainderValue", remainder);
      await prefs.setInt("targetValue", target);
      emit(AppCounterInitial(start, isVibrated, isPlayed, remainder, target));
    }
  }

  void loadRemainderData() async {
    final prefs = await SharedPreferences.getInstance();
    final startCache = prefs.getInt("startValue") ?? 0;
    final remainderCache = prefs.getInt('remainderValue') ?? 33;
    final targetCache = prefs.getInt("targetValue") ?? 1000;
    emit(AppCounterInitial(
        startCache, isVibrated, isPlayed, remainderCache, targetCache));
  }
}
