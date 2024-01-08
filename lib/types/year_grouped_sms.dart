import 'package:pay_tracker/types/date_grouped_sms.dart';
import 'package:pay_tracker/types/monthly_total_spending.dart';

class YearGroupedSms {
  /// eg: ["2023", "2024"]
  late List<String> yearsList;

  /// eg: ["Jan 2023", "Mar 2024"]
  late List<String> monthsList;

  /// eg: { "Jan 2024": 1234.99 }
  Map<String, double> monthlyTotalSpendingsMap = {};

  /// eg: [ "Jan 2024": 1234.99 ]
  List<MonthlyTotalSpending> monthlyTotalSpendingsList = [];

  YearGroupedSms(List<DateGroupedSms> dateGroupedmessages) {
    Set<String> yearListSet = {};
    Set<String> monthListSet = {};
    for (var dateGroupedSms in dateGroupedmessages) {
      String monthAndYear = '${dateGroupedSms.month} ${dateGroupedSms.year}';
      monthListSet.add(monthAndYear);
      monthlyTotalSpendingsMap.update(
        monthAndYear,
        (value) => (value +
            dateGroupedSms.creditCardsTotalCurrencyValue +
            dateGroupedSms.debitCardsTotalCurrencyValue),
        ifAbsent: () =>
            dateGroupedSms.creditCardsTotalCurrencyValue +
            dateGroupedSms.debitCardsTotalCurrencyValue,
      );
      yearListSet.add(dateGroupedSms.year);
    }
    monthsList = monthListSet.toList(growable: false);
    yearsList = yearListSet.toList(growable: false);
    monthlyTotalSpendingsList = monthlyTotalSpendingsMap.entries
        .map((monthlySpendingMap) => MonthlyTotalSpending(
            monthlySpendingMap.key, monthlySpendingMap.value))
        .toList();
  }
}
