import 'package:pay_tracker/types/date_grouped_sms.dart';

class PlacesSpentData {
  /// eg: { ... "Sep 2024":{MonthlySpending}, "Oct 2024":{MonthlySpending} ... }
  late Map<String, MonthlySpending> placesSpentData;

  PlacesSpentData(
      List<DateGroupedSms> dateGroupedMessages, List<String> monthsList) {
    placesSpentData = Map.fromEntries(
      monthsList.map(
        (monthAndYear) => MapEntry(
          monthAndYear,
          MonthlySpending(
            yearlySpending,
            monthAndYear,
          ),
        ),
      ),
    );
  }
}
