import 'package:intl/intl.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/displayed_sms.dart';
import 'package:pay_tracker/utilities/shared/shared_utilities.dart';

class DateGroupedSms {
  /// eg: "Sat"
  late String dayOfTheWeek;

  /// eg: "26"
  late String day;

  /// eg: "Aug"
  late String month;

  /// eg: "2023"
  late String year;

  /// eg: "Sat, 26 Aug 2023"
  late String date;

  /// eg: "AED"
  late String currencyName;

  /// eg: 1024.99
  double creditCardsTotalCurrencyValue = 0;

  /// eg: 512.99
  double debitCardsTotalCurrencyValue = 0;

  /// eg: { "0189":1024.99 }
  late Map<String, double> creditCardsCurrencyValues = {};

  /// eg: { "0189":1024.99 }
  late Map<String, double> debitCardsCurrencyValues = {};

  /// eg: { "0189":[..DisplayedSms...] }
  late Map<String, List<DisplayedSms>> creditCards = {};

  /// eg: { "0189":[..DisplayedSms...] }
  late Map<String, List<DisplayedSms>> debitCards = {};

  DateGroupedSms(List<DisplayedSms> messages) {
    List<String> dateFormat = DateFormat('EEE,dd,MMM,y')
        .format(DateTime(int.parse(messages[0].year),
            getMonthNumber(messages[0].month), int.parse(messages[0].day)))
        .split(',');
    dayOfTheWeek = dateFormat[0];
    day = dateFormat[1];
    month = dateFormat[2];
    year = dateFormat[3];
    date = '$dayOfTheWeek, $day $month $year';
    currencyName = messages[0].currencyName;
    for (var message in messages) {
      if (message.cardType == CardType.creditCard) {
        if (creditCards.containsKey(message.cardNumber)) {
          creditCards[message.cardNumber]?.add(message);
        } else {
          creditCards[message.cardNumber] = [message];
        }

        if (creditCardsCurrencyValues.containsKey(message.cardNumber)) {
          creditCardsCurrencyValues[message.cardNumber] =
              creditCardsCurrencyValues[message.cardNumber]! +
                  message.currencyValue;
        } else {
          creditCardsCurrencyValues[message.cardNumber] = message.currencyValue;
        }

        creditCardsTotalCurrencyValue += message.currencyValue;
      } else if (message.cardType == CardType.debitCard) {
        if (debitCards.containsKey(message.cardNumber)) {
          debitCards[message.cardNumber]?.add(message);
        } else {
          debitCards[message.cardNumber] = [message];
        }

        if (debitCardsCurrencyValues.containsKey(message.cardNumber)) {
          debitCardsCurrencyValues[message.cardNumber] =
              debitCardsCurrencyValues[message.cardNumber]! +
                  message.currencyValue;
        } else {
          debitCardsCurrencyValues[message.cardNumber] = message.currencyValue;
        }

        debitCardsTotalCurrencyValue += message.currencyValue;
      }
    }
  }
}
