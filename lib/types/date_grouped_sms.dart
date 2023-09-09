import 'package:intl/intl.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/displayed_sms.dart';

class DateGroupedSms {
  /// eg: "Sat, 26 Aug 2023"
  late String date;

  /// eg: "AED"
  late String currencyName;

  /// eg: 1024.99
  double creditCardsTotalCurrencyValue = 0;

  /// eg: 512.99
  double debitCardsTotalCurrencyValue = 0;

  late List<DisplayedSms> creditCards = [];
  late List<DisplayedSms> debitCards = [];

  DateGroupedSms(List<DisplayedSms> messages) {
    date = DateFormat('EEE, dd MMM y').format(messages[0].dateTime);
    currencyName = messages[0].currencyName;
    for (var message in messages) {
      if (message.cardType == CardType.creditCard) {
        creditCards.add(message);
        creditCardsTotalCurrencyValue += message.currencyValue;
      } else if (message.cardType == CardType.debitCard) {
        debitCards.add(message);
        debitCardsTotalCurrencyValue += message.currencyValue;
      }
    }
  }
}
