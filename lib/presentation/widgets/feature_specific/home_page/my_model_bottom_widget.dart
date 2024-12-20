import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';

import '../../../../config/theme/colors.dart';
import '../../../../constants/responsive.dart';
import 'input_field_widget.dart';

class MyModelBottomWidget extends StatefulWidget {
  const MyModelBottomWidget({super.key});

  @override
  State<MyModelBottomWidget> createState() => _MyModelBottomWidgetState();
}

class _MyModelBottomWidgetState extends State<MyModelBottomWidget> {
  final TextEditingController startValueController = TextEditingController();

  final TextEditingController remainderController = TextEditingController();

  final TextEditingController targetValueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _sizedBox = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? MyColors.white;
    final iconColor = theme.iconTheme.color;
    final FocusNode startValueFocusNode = FocusNode();
    final FocusNode remainderFocusNode = FocusNode();
    final FocusNode targetValueFocusNode = FocusNode();

    return Padding(
      padding: EdgeInsets.only(
        left: Responsive.width(0.04),
        right: Responsive.width(0.04),
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
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
                      size: Responsive.height(0.04),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: 270, // Set a fixed or flexible width
                    child: Text(
                      "Set Reminder".tr(),
                      style: TextStyle(
                        color: textColor,
                        fontSize: Responsive.height(0.028),
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check_outlined,
                      color: MyColors.green,
                      size: Responsive.height(0.05),
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
                label: "Start Value".tr(),
                hint: '0',
                focusNode: startValueFocusNode,
                controller: startValueController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a Start Value".tr();
                  }

                  if (int.tryParse(value) == null) {
                    return "Please enter a valid number".tr();
                  }
                  return null;
                },
              ),
              _sizedBox,
              InputFieldReminder(
                label: "Reminder".tr(),
                focusNode: remainderFocusNode,
                hint: '33',
                controller: remainderController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a Remainder value".tr();
                  }

                  if (int.tryParse(value) == null ||
                      int.tryParse(value)! <= 0) {
                    return "Please enter a valid positive number".tr();
                  }

                  return null;
                },
              ),
              _sizedBox,
              InputFieldReminder(
                label: "Target Value".tr(),
                focusNode: targetValueFocusNode,
                hint: '99',
                controller: targetValueController,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.parse(value) <
                          context.read<AppCounterCubit>().currentCounter) {
                    return "Please enter a Target value".tr();
                  }

                  if (int.tryParse(value) == null ||
                      int.tryParse(value)! <= 0) {
                    return "Please enter a valid positive number".tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<AppCounterCubit, AppCounterState>(
                builder: (context, state) {
                  if (state is AppCounterValidationFailed) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.startValueError != null)
                          Text(state.startValueError!,
                              style: TextStyle(color: theme.colorScheme.error)),
                        if (state.remainderValueError != null)
                          Text(state.remainderValueError!,
                              style: TextStyle(color: theme.colorScheme.error)),
                        if (state.targetValueError != null)
                          Text(state.targetValueError!,
                              style: TextStyle(color: theme.colorScheme.error)),
                      ],
                    );
                  }
                  return const SizedBox.shrink(); // No error message to display
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
