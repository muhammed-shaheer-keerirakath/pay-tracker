import 'dart:convert';
import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';
import 'package:pay_tracker/utilities/shared/shared_utilities.dart';

class InboxSmsMessage {
  late List<String> date;
  late String address;
  late String body;

  InboxSmsMessage(this.date, this.address, this.body);

  factory InboxSmsMessage.fromMockJson(dynamic json) {
    List<String> dateSplitList = (json['date'] as String).split('-');
    String dateWeekDay = DateFormat(threeLetterWeekDayFormat).format(DateTime.parse(
        '${dateSplitList[2]}-${getMonthNumber(dateSplitList[1]).toString().padLeft(2, '0')}-${dateSplitList[0]}'));
    List<String> mockDate =
        dateSplitList.sublist(0, 3) + [dateWeekDay] + dateSplitList.sublist(3);
    log(jsonEncode(mockDate));
    return InboxSmsMessage(mockDate, smsAddress, json['body'] as String);
  }
}
