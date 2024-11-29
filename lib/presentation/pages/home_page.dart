import 'package:flutter/material.dart';
import 'package:tasbeh/config/theme/colors.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/home_page_bottom_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/show_history_button_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/tasbeh_count_button_widget.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/home_page/tasbeh_reset_button_widget.dart';

import '../widgets/feature_specific/home_page/my_custom_painter.dart';
import '../widgets/feature_specific/home_page/progress_bar_widget.dart';
import '../widgets/feature_specific/home_page/tasbeh_screen_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkGrey,
      appBar: AppBar(
        leading: const ShowHistoryButtonWidget(),
        backgroundColor: MyColors.darkGrey,
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
                  painter: MyTasbehPainter(),
                ),
                const TasbehScreenWidget(),
                const TasbehResetButtonWidget(),
                const TasbehCountButtonWidget(),
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
