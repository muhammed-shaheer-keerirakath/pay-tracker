import 'package:pay_tracker/types/date_grouped_sms.dart';

class MonthlySpending {
  /// eg: "Sep"
  String currentMonth = "";

  /// eg: "2023"
  String currentYear = "";

  /// eg: 1024.99
  double creditCardsTotalSpending = 0;

  /// eg: 512.99
  double debitCardsTotalSpending = 0;

  /// eg: "AED"
  String currencyName = "";

  /// eg: 1537.98
  double totalSpending = 0;

  MonthlySpending.empty();
  MonthlySpending(Map<String, List<DateGroupedSms>> yearlySpending,
      String month, this.currentMonth, this.currentYear) {
    yearlySpending[month]?.forEach((dateGroupedMessage) {
      currencyName = dateGroupedMessage.currencyName;
      creditCardsTotalSpending +=
          dateGroupedMessage.creditCardsTotalCurrencyValue;
      debitCardsTotalSpending +=
          dateGroupedMessage.debitCardsTotalCurrencyValue;
    });
    totalSpending = creditCardsTotalSpending + debitCardsTotalSpending;
  }
}
