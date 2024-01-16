import 'package:flutter/material.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/monthly_total_spending.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlyGraph extends StatelessWidget {
  const MonthlyGraph({super.key});

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          title: const ChartTitle(text: 'Monthly Spendings'),
          series: <LineSeries<MonthlyTotalSpending, String>>[
            LineSeries<MonthlyTotalSpending, String>(
              dataSource:
                  messageStoreModel.monthlyTotalSpendings.reversed.toList(),
              xValueMapper: (MonthlyTotalSpending monthlyTotalSpending, _) =>
                  monthlyTotalSpending.monthAndYear,
              yValueMapper: (MonthlyTotalSpending monthlyTotalSpending, _) =>
                  monthlyTotalSpending.totalSpending,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            )
          ]),
    );
  }
}
