import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/monthly_graph/monthly_graph_constants.dart';
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

    bool hasAllTimeRangeSelected =
        messageStoreModel.monthlyGraphRange == MonthlyGraphConstants.allTime;
    List<String> allowedMonthYear = ["Mar 2024"];
    List<MonthlyTotalSpending> monthlyGraphDataSource = [];
    monthlyGraphDataSource = hasAllTimeRangeSelected
        ? messageStoreModel.monthlyTotalSpendings
        : messageStoreModel.monthlyTotalSpendings
            .where((element) => allowedMonthYear.contains(element.monthAndYear))
            .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: SfCartesianChart(
                    primaryXAxis: const CategoryAxis(),
                    title: const ChartTitle(text: 'Monthly Spendings'),
                    series: <LineSeries<MonthlyTotalSpending, String>>[
                      LineSeries<MonthlyTotalSpending, String>(
                        dataSource: monthlyGraphDataSource,
                        xValueMapper:
                            (MonthlyTotalSpending monthlyTotalSpending, _) =>
                                monthlyTotalSpending.monthAndYear,
                        yValueMapper:
                            (MonthlyTotalSpending monthlyTotalSpending, _) =>
                                monthlyTotalSpending.totalSpending,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true),
                      )
                    ]),
              ),
              const SizedBox(
                height: 8,
              ),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment<String>(
                      value: MonthlyGraphConstants.allTime,
                      label: Text(MonthlyGraphConstants.allTime),
                      icon: Icon(Icons.calendar_view_month)),
                  ButtonSegment<String>(
                      value: MonthlyGraphConstants.past6Months,
                      label: Text(MonthlyGraphConstants.past6Months),
                      icon: Icon(Icons.calendar_month)),
                  ButtonSegment<String>(
                      value: MonthlyGraphConstants.past3Months,
                      label: Text(MonthlyGraphConstants.past3Months),
                      icon: Icon(Icons.calendar_month)),
                ],
                selected: {messageStoreModel.monthlyGraphRange},
                onSelectionChanged: (Set<String> segmentSelections) {
                  messageStoreModel
                      .changeMonthlyGraphRange(segmentSelections.first);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
