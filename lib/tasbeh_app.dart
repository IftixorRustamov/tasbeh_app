import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasbeh/constants/responsive.dart';
import 'package:tasbeh/logic/counter/app_counter_cubit.dart';
import 'package:tasbeh/presentation/pages/history_page.dart';
import 'package:tasbeh/presentation/pages/home_page.dart';
import 'package:tasbeh/presentation/pages/splash_page.dart';

class TasbehApp extends StatelessWidget {
  const TasbehApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return BlocProvider(
      create: (context) => AppCounterCubit()..loadRemainderData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          'home-page': (context) => const HomePage(),
          'history-page': (context) => const HistoryPage()
        },
      ),
    );
  }
}
