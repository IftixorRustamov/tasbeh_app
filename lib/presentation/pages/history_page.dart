import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasbeh/data/models/counter_history.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/history_page/history_page_close_button_widget.dart';

import '../../config/theme/colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyBox = Hive.box<CounterHistory>('historyBox');
    final history = historyBox.values.toList();

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
      body: history.isNotEmpty
          ? ListView.builder(
              itemCount: history.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final record = history[index];
                final date = record.countedDate.toLocal();
                final formattedDate = "${date.day}/${date.month}/${date.year}";
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: MyColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: ListTile(
                    title: Text(
                      "Count: ${record.counter}",
                      style: TextStyle(
                        color: MyColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "Date: $formattedDate",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                "No History Available yet",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
    );
  }
}
