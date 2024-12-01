import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class ShowHistoryButtonWidget extends StatelessWidget {
  const ShowHistoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color ?? Colors.white;
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed('history-page');
      },
      icon: Icon(
        Icons.history,
        color: iconColor,
        size: 35,
      ),
    );
  }
}
