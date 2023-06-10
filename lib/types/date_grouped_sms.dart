import 'package:intl/intl.dart';
import 'package:pay_tracker/types/displayed_sms.dart';

class DateGroupedSms {
  late String date;
  late List<DisplayedSms> creditCards = [];
  late List<DisplayedSms> debitCards = [];

  DateGroupedSms(List<DisplayedSms> messages) {
    date = DateFormat('EEE, dd MMM y').format(messages[0].dateTime);
    for (var message in messages) {
      if (message.cardType == 'Credit Card') {
        creditCards.add(message);
      } else if (message.cardType == 'Debit Card') {
        debitCards.add(message);
      }
    }
  }
}
