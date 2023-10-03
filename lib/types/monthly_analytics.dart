import 'package:intl/intl.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';
import 'package:pay_tracker/types/monthly_spending.dart';

class MonthlyAnalytics {
  /// eg: "2023"
  late String currentYear;

  /// eg: "Sep"
  late String currentMonth;

  /// eg: "1"
  late String currentDay;

  /// eg: { ... "Sep":{MonthlySpending}, "Oct":{MonthlySpending} ... }
  late Map<String, MonthlySpending> monthlySpending;

  MonthlyAnalytics(List<DateGroupedSms> dateGroupedMessages) {
    Map<String, List<DateGroupedSms>> yearlySpending =
        Map.fromEntries(monthsMMMFormat.map((month) => MapEntry(month, [])));

    final List<String> presentFormattedDate =
        DateFormat(cardDateGroupedFormat).format(DateTime.now()).split('-');
    currentDay = presentFormattedDate[0];
    currentMonth = presentFormattedDate[1];
    currentYear = presentFormattedDate[2];
    for (var dateGroupedMessage in dateGroupedMessages) {
      List<String> dateSplit = dateGroupedMessage.date.split(" ");
      String presentDateMonth = dateSplit[2];
      String presentDateYear = dateSplit[3];
      if (presentDateYear == currentYear) {
        yearlySpending[presentDateMonth]?.add(dateGroupedMessage);
      }
    }

    monthlySpending = Map.fromEntries(
      monthsMMMFormat.map(
        (month) => MapEntry(
          month,
          MonthlySpending(
            yearlySpending,
            month,
            currentMonth,
            currentYear,
          ),
        ),
      ),
    );
  }
}
