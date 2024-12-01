import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasbeh/config/theme/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) Navigator.of(context).pushReplacementNamed("home-page");
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = theme.brightness == Brightness.dark
        ? MyColors.darkGrey // Dark mode background
        : MyColors.silver; // Light mode background

    final imageColor = theme.brightness == Brightness.dark
        ? Colors.white60 // Dark mode image color
        : MyColors.darkGrey; // Light mode image color

    final progressColor = theme.brightness == Brightness.dark
        ? MyColors.darkGreen // Dark mode progress color
        : MyColors.blue; // Light mode progress color

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/counter_vector 1.png",
                  color: imageColor,
                  width: 160,
                  height: 160,
                ),
                Positioned(
                  top: 100,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      color: progressColor,
                      strokeWidth: 5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
