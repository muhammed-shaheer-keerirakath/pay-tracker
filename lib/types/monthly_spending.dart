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

  /// eg: { "0189":1024.99 }
  late Map<String, double> creditCardsMonthlyCurrencyValues = {};

  /// eg: { "0189":1024.99 }
  late Map<String, double> debitCardsMonthlyCurrencyValues = {};

  MonthlySpending.empty();

  MonthlySpending(Map<String, List<DateGroupedSms>> yearlySpending,
      String month, this.currentMonth, this.currentYear) {
    yearlySpending[month]?.forEach((dateGroupedMessage) {
      currencyName = dateGroupedMessage.currencyName;

      dateGroupedMessage.creditCards.forEach((cardNumber, cardPayments) {
        if (creditCardsMonthlyCurrencyValues.containsKey(cardNumber)) {
          creditCardsMonthlyCurrencyValues[cardNumber] =
              creditCardsMonthlyCurrencyValues[cardNumber]! +
                  cardPayments
                      .map((e) => e.currencyValue)
                      .reduce((value, element) => value + element);
        } else {
          creditCardsMonthlyCurrencyValues[cardNumber] = cardPayments
              .map((e) => e.currencyValue)
              .reduce((value, element) => value + element);
        }
      });

      creditCardsTotalSpending +=
          dateGroupedMessage.creditCardsTotalCurrencyValue;

      dateGroupedMessage.debitCards.forEach((cardNumber, cardPayments) {
        if (debitCardsMonthlyCurrencyValues.containsKey(cardNumber)) {
          debitCardsMonthlyCurrencyValues[cardNumber] =
              debitCardsMonthlyCurrencyValues[cardNumber]! +
                  cardPayments
                      .map((e) => e.currencyValue)
                      .reduce((value, element) => value + element);
        } else {
          debitCardsMonthlyCurrencyValues[cardNumber] = cardPayments
              .map((e) => e.currencyValue)
              .reduce((value, element) => value + element);
        }
      });

      debitCardsTotalSpending +=
          dateGroupedMessage.debitCardsTotalCurrencyValue;
    });
    totalSpending = creditCardsTotalSpending + debitCardsTotalSpending;
  }
}
