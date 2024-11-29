import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class ShowHistoryButtonWidget extends StatelessWidget {
  const ShowHistoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushNamed('history-page');
      },
      icon: const Icon(
        Icons.history,
        color: MyColors.white,
        size: 35,
      ),
    );
  }
}
