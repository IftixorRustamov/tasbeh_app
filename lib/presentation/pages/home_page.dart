import 'package:flutter/material.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/home_page_bottom_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/language_selector_widget.dart';
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
    final circleColor = theme.colorScheme.primary;
    final buttonColor = theme.colorScheme.onPrimary;
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const ShowHistoryButtonWidget(),
        backgroundColor: appBarBackgroundColor,
        title: const ProgressBarWidget(),
        actions: const [
          Padding(
            padding:  EdgeInsets.only(right: 12.0),
            // Add padding to the right
            child: LanguageSelector(),
          ),
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
                  size: Size(Responsive.width(0.7), Responsive.height(0.5)),
                  painter: MyTasbehPainter(circleColor: circleColor),
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
