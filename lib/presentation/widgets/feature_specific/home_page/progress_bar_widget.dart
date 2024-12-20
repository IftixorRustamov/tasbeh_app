import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';
import 'package:tasbeh/main.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/my_model_bottom_widget.dart';

import '../../../../constants/responsive.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
    final progressColor = theme.colorScheme.primary;
    final backgroundProgressColor = theme.colorScheme.surface;

    return BlocBuilder<AppCounterCubit, AppCounterState>(
        builder: (context, state) {
      int remainder = 0;
      int target = 0;
      int counter = 0;

      if (state is AppCounterInitial) {
        remainder = state.remainderValue;
        target = state.targetValue;
        counter = state.counter;
      }

      if (target == counter) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Target Reached!'.tr(),
                  style: TextStyle(color: textColor),
                ),
                content: Text(
                  'congrats'.tr(),
                  style: TextStyle(color: textColor),
                ),
                backgroundColor: theme.colorScheme.surface,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK', style: TextStyle(color: progressColor)),
                  ),
                ],
              );
            },
          );
        });
      }
      double progress = counter / target;
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: theme.colorScheme.surface,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) => const MyModelBottomWidget(),
          );
        },
        child: Column(
          children: [
            Text(
              "str_remainder"
                  .tr(namedArgs: {"remainder": remainder.toString()}),
              style: TextStyle(
                  color: textColor,
                  fontSize: Responsive.height(0.028),
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Responsive.width(0.7),
              child: LinearProgressIndicator(
                value: progress,
                color: progressColor,
                backgroundColor: backgroundProgressColor,
                minHeight: Responsive.height(0.01),
              ),
            ),
          ],
        ),
      );
    });
  }
}
