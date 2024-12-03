import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';
import '../../../../constants/responsive.dart';

class HistoryPageCloseButtonWidget extends StatelessWidget {
  const HistoryPageCloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color ?? MyColors.white;
    final buttonColor = theme.cardColor;
    return Row(
      children: [
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          borderRadius: BorderRadius.circular(30),
          splashColor: theme.colorScheme.primary,
          child: Container(
            height: Responsive.height(0.05),
            width: Responsive.height(0.05),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: buttonColor,
            ),
            child: Icon(
              Icons.close,
              size: Responsive.height(0.04),
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
