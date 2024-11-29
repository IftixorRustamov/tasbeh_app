import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class HistoryPageCloseButtonWidget extends StatelessWidget {
  const HistoryPageCloseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MyColors.grey,
            ),
            child: const Icon(
              Icons.close,
              size: 30,
              color: MyColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
