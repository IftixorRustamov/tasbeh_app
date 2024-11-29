import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class ButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final IconData icon;

  const ButtonWidget({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(35),
      splashColor: MyColors.darkGreen,
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        radius: 40,
        child: Icon(
          icon,
          color: MyColors.white,
          size: 40,
        ),
      ),
    );
  }
}
