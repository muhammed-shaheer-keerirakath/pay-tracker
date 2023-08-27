import 'package:intl/intl.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';

class DisplayedSms {
  /// eg: "AED 12.50"
  late String purchasedAmount;

  /// eg: "AED"
  late String currencyName;

  /// eg: 12.50
  late double currencyValue;

  /// eg: "Dubai Mall"
  late String purchasedAt;

  /// eg: "Debit Card" | "Credit Card"
  late String cardType;

  /// eg: "0189"
  late String cardNumber;

  /// eg: "AED 87.50"
  late String availableAmount;

  /// eg: "Avl. Balance" | "Cr. Limit"
  late String balanceType;

  /// eg: DateTime (2023-06-04 02:59:59.345)
  late DateTime dateTime;

  /// eg: "04"
  late String day;

  /// eg: "Jun"
  late String month;

  /// eg: "2023"
  late String year;

  /// eg: "Sun"
  late String weekday;

  /// eg: "02"
  late String hour;

  /// eg: "59"
  late String minute;

  /// eg: "AM" | "PM"
  late String amPm;

  DisplayedSms(RegExpMatch? smsBodyRegex, InboxSmsMessage sms) {
    if (smsBodyRegex != null) {
      purchasedAmount = smsBodyRegex.namedGroup('purchasedAmount') ?? '';
      currencyName = purchasedAmount.split(' ')[0];
      currencyValue = double.parse(
          purchasedAmount.split(' ')[1].replaceAll(RegExp('[^0-9.]'), ''));
      purchasedAt = smsBodyRegex.namedGroup('purchasedAt') ?? '';
      cardType = smsBodyRegex.namedGroup('cardType') ?? '';
      cardNumber = smsBodyRegex.namedGroup('cardNumber') ?? '';
      availableAmount = smsBodyRegex.namedGroup('availableAmount') ?? '';
      balanceType = smsBodyRegex.namedGroup('availableAmountType') ?? '';
      dateTime = DateTime.fromMillisecondsSinceEpoch(sms.date);
      List<String> dateFormat =
          DateFormat(cardDateGroupedFormat).format(dateTime).split('-');
      day = dateFormat[0];
      month = dateFormat[1];
      year = dateFormat[2];
      weekday = dateFormat[3];
      hour = dateFormat[4];
      minute = dateFormat[5];
      amPm = dateFormat[6];
    }
  }
}
