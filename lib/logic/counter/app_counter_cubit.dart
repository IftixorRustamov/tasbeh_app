import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/theme/colors.dart';

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

  void saveRemainderData(
      String startValue, String remainderValue, String targetValue) async {
    final start = int.parse(startValue);
    final remainder = int.parse(remainderValue);
    final target = int.parse(targetValue);

    if (start < 0 || remainder <= 0 || target < 0) {
      throw Exception("Invalid values entered");
    }

    if (start >= target) {
      throw Exception("Start value must be less than the Target value");
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("startValue", start);
    await prefs.setInt("remainderValue", remainder);
    await prefs.setInt("targetValue", target);

    emit(AppCounterInitial(start, isVibrated, isPlayed, remainder, target));
  }

  Future<void> checkInputValidation(BuildContext context, String startValue,
      String remainderValue, String targetValue) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Data saved successfully"),
        backgroundColor: MyColors.darkGreen,
      ));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
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
