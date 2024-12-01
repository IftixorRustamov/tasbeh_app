import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const ButtonWidget({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final splashColor = theme.colorScheme.primary;
    final iconColor = theme.iconTheme.color ?? MyColors.white;
    final backgroundColor = theme.scaffoldBackgroundColor == MyColors.silver
        ? Colors.grey.shade800 // Light theme specific background
        : theme.cardColor;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(35),
      splashColor: splashColor,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        radius: 40,
        child: Icon(
          icon,
          color: iconColor,
          size: 40,
        ),
      ),
    );
  }
}
