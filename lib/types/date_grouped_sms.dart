import 'package:intl/intl.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/displayed_sms.dart';

class DateGroupedSms {
  /// eg: "Sat, 26 Aug 2023"
  late String date;

  /// eg: "Aug"
  late String currentMonth;

  /// eg: "AED"
  late String dailySpendCurrencyName;

  /// eg: 99.80
  late double dailySpend = 0;
  late List<DisplayedSms> creditCards = [];
  late List<DisplayedSms> debitCards = [];

  DateGroupedSms(List<DisplayedSms> messages) {
    date = DateFormat('EEE, dd MMM y').format(messages[0].dateTime);
    currentMonth = messages[0].month;
    dailySpendCurrencyName = messages[0].currencyName;
    for (var message in messages) {
      dailySpend += message.currencyValue;
      if (message.cardType == CardType.creditCard) {
        creditCards.add(message);
      } else if (message.cardType == CardType.debitCard) {
        debitCards.add(message);
      }
    }
  }
}
