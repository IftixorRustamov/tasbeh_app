import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';

import '../../common/button_widget.dart';

class HomePageBottomWidget extends StatefulWidget {
  const HomePageBottomWidget({super.key});

  @override
  State<HomePageBottomWidget> createState() => _HomePageBottomWidgetState();
}

class _HomePageBottomWidgetState extends State<HomePageBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: BlocBuilder<AppCounterCubit, AppCounterState>(
          builder: (context, state) {
        final isPlayed = (state as AppCounterInitial).isPlayed;
        final isVibrated = (state).isVibrated;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Sound Button
            ButtonWidget(
              onPressed: () => context.read<AppCounterCubit>().togglePlayer(),
              icon: isPlayed ? Icons.volume_up : Icons.volume_off,
            ),

            // Vibration Button
            ButtonWidget(
              onPressed: () =>
                  context.read<AppCounterCubit>().toggleVibration(),
              icon: isVibrated ? Icons.vibration : Icons.mobile_off,
            ),

            // Dark Mode Button
            ButtonWidget(onPressed: () {}, icon: CupertinoIcons.moon_fill),
          ],
        );
      }),
    );
  }
}
