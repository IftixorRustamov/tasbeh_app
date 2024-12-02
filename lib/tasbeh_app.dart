import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/constants/responsive.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';
import 'package:tasbeh/logic/theme_cubit/theme_cubit.dart';
import 'package:tasbeh/presentation/pages/history_page.dart';
import 'package:tasbeh/presentation/pages/home_page.dart';
import 'package:tasbeh/presentation/pages/splash_page.dart';

import 'config/theme/light_dark_mode.dart';

class TasbehApp extends StatelessWidget {
  const TasbehApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCounterCubit()..loadRemainderData()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final currentTheme =
              state is ThemeChanged ? state.themeData : ThemeData.light();

          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode: currentTheme.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            routes: {
              '/': (context) => const SplashPage(),
              'home-page': (context) => const HomePage(),
              'history-page': (context) => const HistoryPage()
            },
          );
        },
      ),
    );
  }
}
