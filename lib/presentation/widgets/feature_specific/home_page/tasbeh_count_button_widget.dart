import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/constants/responsive.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';

class TasbehCountButtonWidget extends StatelessWidget {
  final Color buttonColor;

  const TasbehCountButtonWidget({super.key, required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Responsive.height(0.4),
      left: Responsive.width(0.21),
      child: InkWell(
        onTap: () {
          context.read<AppCounterCubit>().increment();
        },
        child: Container(
          height: Responsive.height(0.15),
          width: Responsive.width(0.3),
          decoration: BoxDecoration(
            color: buttonColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
