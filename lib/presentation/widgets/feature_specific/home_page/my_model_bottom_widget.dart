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
    final theme = Theme.of(context);
    final buttonColor = theme.colorScheme.primary;
    final textColor = theme.textTheme.bodyLarge?.color ?? MyColors.white;
    final iconColor = theme.iconTheme.color;
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 30,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: iconColor,
                            size: 25,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text(
                          "Set Reminder",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            color: buttonColor,
                            size: 25,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String startValue = startValueController.text;
                              String remainder = remainderController.text;
                              String targetValue = targetValueController.text;

                              context.read<AppCounterCubit>().saveRemainderData(
                                  startValue, remainder, targetValue);
                              Navigator.of(context).pop();
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

                        if (int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
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
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value) <
                                context
                                    .read<AppCounterCubit>()
                                    .currentCounter) {
                          return "Please enter a Target value";
                        }

                        if (int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return "Please enter a valid positive number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<AppCounterCubit, AppCounterState>(
                      builder: (context, state) {
                        if (state is AppCounterValidationFailed) {
                          return Column(
                            children: [
                              if (state.startValueError != null)
                                Text(state.startValueError!,
                                    style: TextStyle(
                                        color: theme.colorScheme.error)),
                              if (state.remainderValueError != null)
                                Text(state.remainderValueError!,
                                    style: TextStyle(
                                        color: theme.colorScheme.error)),
                              if (state.targetValueError != null)
                                Text(state.targetValueError!,
                                    style: TextStyle(
                                        color: theme.colorScheme.error)),
                            ],
                          );
                        }
                        return const SizedBox
                            .shrink(); // No error message to display
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
