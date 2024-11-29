import 'package:flutter/material.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/history_page/history_page_close_button_widget.dart';

import '../../config/theme/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkGrey,
      appBar: AppBar(
        backgroundColor: MyColors.darkGrey,
        leading: const HistoryPageCloseButtonWidget(),
        title: const Text(
          "History",
          style: TextStyle(
            color: MyColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
              color: MyColors.grey,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ListTile(
            title: Text(
              "SMTH",
              style: TextStyle(
                color: MyColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "How many times counted",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
