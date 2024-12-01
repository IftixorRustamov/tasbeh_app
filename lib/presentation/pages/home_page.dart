import 'package:flutter/material.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/home_page_bottom_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/show_history_button_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/tasbeh_count_button_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/tasbeh_reset_button_widget.dart';

import '../../constants/responsive.dart';
import '../widgets/feature_specific/home_page/my_custom_painter.dart';
import '../widgets/feature_specific/home_page/progress_bar_widget.dart';
import '../widgets/feature_specific/home_page/tasbeh_screen_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final appBarBackgroundColor = theme.appBarTheme.backgroundColor;
    final buttonColor = theme.colorScheme.primary;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const ShowHistoryButtonWidget(),
        backgroundColor: appBarBackgroundColor,
        title: ProgressBarWidget(),
        actions: const [
          SizedBox(width: 50),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(300, 400),
                  painter: MyTasbehPainter(circleColor: buttonColor),
                ),
                const TasbehScreenWidget(),
                TasbehResetButtonWidget(
                  buttonColor: buttonColor,
                  textColor: textColor,
                ),
                TasbehCountButtonWidget(
                  buttonColor: buttonColor,
                ),
              ],
            ),
          ),
          // Bottom Section
          const HomePageBottomWidget(),
        ],
      ),
    );
  }
}
