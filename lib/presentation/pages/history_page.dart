import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tasbeh/data/models/counter_history.dart';
import 'package:tasbeh/presentation/widgets/feature_specific/history_page/history_page_close_button_widget.dart';

import '../../constants/responsive.dart';

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
          "History".tr(),
          style: TextStyle(
            color: titleColor,
            fontSize: Responsive.width(0.06),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: history.isNotEmpty
          ? ListView.builder(
              itemCount: history.length,
              padding: EdgeInsets.all(Responsive.width(0.04)),
              itemBuilder: (context, index) {
                final record = history[index];
                final date = record.countedDate.toLocal();
                final formattedDate = "${date.day}/${date.month}/${date.year}";
                return Container(
                  margin: EdgeInsets.only(bottom: Responsive.height(0.02)),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: ListTile(
                    title: Text(
                      "Count:".tr(
                          namedArgs: {"count": record.counter.toString()},
                          context: context),
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Responsive.width(0.04),
                      ),
                    ),
                    subtitle: Text(
                      "Date".tr(namedArgs: {'date': formattedDate}),
                      style: TextStyle(
                          fontSize: Responsive.width(0.04),
                          color: subtitleColor),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                "No History Available yet".tr(),
                style: TextStyle(
                    color: textColor, fontSize: Responsive.width(0.04)),
              ),
            ),
    );
  }
}
