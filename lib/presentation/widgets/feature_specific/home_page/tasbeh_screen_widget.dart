import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/constants/responsive.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';

class TasbehScreenWidget extends StatelessWidget {
  const TasbehScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.surface;
    final textColor = theme.textTheme.bodyLarge?.color;
    return Positioned(
      top: Responsive.height(0.21),
      child: BlocBuilder<AppCounterCubit, AppCounterState>(
        builder: (context, state) {
          final counter = (state is AppCounterInitial) ? state.counter : 0;
          return Container(
            height: Responsive.height(0.09),
            width: Responsive.width(0.5),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "$counter",
                  style: TextStyle(
                      fontSize: 38, fontFamily: "DSEG", color: textColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
