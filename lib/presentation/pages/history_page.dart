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

    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final textColor = theme.textTheme.bodyLarge?.color;
    final cardColor = theme.cardColor;
    final titleColor = theme.textTheme.titleLarge?.color;
    final subtitleColor = theme.textTheme.titleMedium?.color;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: const HistoryPageCloseButtonWidget(),
        title: Text(
          "History",
          style: TextStyle(
            color: titleColor,
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
                  decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: ListTile(
                    title: Text(
                      "Count: ${record.counter}",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "Date: $formattedDate",
                      style: TextStyle(fontSize: 16, color: subtitleColor),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                "No History Available yet",
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
    );
  }
}
