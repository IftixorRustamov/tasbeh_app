import 'package:flutter/material.dart';

import '../../../../constants/responsive.dart';

class ShowHistoryButtonWidget extends StatelessWidget {
  const ShowHistoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color;
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed('history-page');
      },
      icon: Icon(
        Icons.history,
        color: iconColor,
        size: Responsive.width(0.08),
      ),
    );
  }
}
