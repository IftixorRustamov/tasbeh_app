import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';

import '../../../../config/theme/colors.dart';
import 'input_field_widget.dart';

class MyModelBottomWidget extends StatelessWidget {
  MyModelBottomWidget({super.key});

  final TextEditingController startValueController = TextEditingController();
  final TextEditingController remainderController = TextEditingController();
  final TextEditingController targetValueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _sizedBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Text(
                  "Set Reminder",
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: MyColors.darkGreen,
                    size: 25,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String startValue = startValueController.text;
                      String remainder = remainderController.text;
                      String targetValue = targetValueController.text;
                      context.read<AppCounterCubit>().saveRemainderData(
                          startValue, remainder, targetValue);
                      try {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
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
                  },
                ),
              ],
            ),
            _sizedBox,
            InputFieldReminder(
              label: "Start Value",
              hint: '0',
              controller: startValueController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a Start Value";
                }

                if (int.tryParse(value) == null) {
                  return "Please enter a valid number";
                }
                return null;
              },
            ),
            _sizedBox,
            InputFieldReminder(
              label: "Remainder",
              hint: '33',
              controller: remainderController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a Remainder value";
                }

                if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
                  return "Please enter a valid positive number";
                }

                return null;
              },
            ),
            _sizedBox,
            InputFieldReminder(
              label: "Target Value",
              hint: '99',
              controller: targetValueController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a Target value";
                }

                if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
                  return "Please enter a valid positive number";
                }
                return null;
              },
            ),
            _sizedBox,
          ],
        ),
      ),
    );
  }
}
