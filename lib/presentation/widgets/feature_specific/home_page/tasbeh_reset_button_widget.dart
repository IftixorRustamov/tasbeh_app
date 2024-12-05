import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/constants/responsive.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';
import '../../../../config/theme/colors.dart';

class TasbehResetButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;

  const TasbehResetButtonWidget({
    super.key,
    required this.buttonColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Responsive.height(0.34),
      left: Responsive.width(0.46),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
                return AlertDialog.adaptive(
                  title: Text(context.tr("Reset Counter")),
                  content:
                      const Text("Are you sure you want to reset the counter?")
                          .tr(),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "Cancel".tr(),
                        style: TextStyle(
                            color: isIOS ? MyColors.blue : MyColors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        context.read<AppCounterCubit>().reset();
                      },
                      child: Text(
                        "Reset".tr(),
                        style: TextStyle(
                            color: isIOS ? MyColors.red : MyColors.black),
                      ),
                    ),
                  ],
                );
              });
        },
        child: Container(
          height: Responsive.height(0.06),
          width: Responsive.width(0.12),
          decoration: BoxDecoration(
            color: buttonColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            CupertinoIcons.restart,
            color: textColor,
            size: Responsive.width(0.06),
          ),
        ),
      ),
    );
  }
}
