import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/config/theme/colors.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/my_model_bottom_widget.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Target Reached!',
                  style: TextStyle(),
                ),
                content: Text(
                  'Congratulations 🎉🎉🎉! You have reached your target.',
                  style: TextStyle(),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK'),
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
            context: context,
            backgroundColor: MyColors.darkGrey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) => MyModelBottomWidget(),
          );
        },
        child: Column(
          children: [
            Text(
              "Remainder: $remainder",
              style: const TextStyle(
                  color: MyColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              color: MyColors.darkGreen,
              backgroundColor: Colors.grey.shade800,
              minHeight: 7,
            ),
          ],
        ),
      );
    });
  }
}
