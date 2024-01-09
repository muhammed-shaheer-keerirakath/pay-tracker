import 'package:intl/intl.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';
import 'package:pay_tracker/utilities/shared/shared_utilities.dart';

class InboxSmsMessage {
  late int dateInMilliSeconds;
  late List<String> date;
  late String address;
  late String body;

  InboxSmsMessage(this.dateInMilliSeconds, this.date, this.address, this.body);

  factory InboxSmsMessage.fromMockJson(dynamic json) {
    List<String> dateSplitList = (json['date'] as String).split('-');
    String dateWeekDay = DateFormat(threeLetterWeekDayFormat).format(DateTime.parse(
        '${dateSplitList[2]}-${getMonthNumber(dateSplitList[1]).toString().padLeft(2, '0')}-${dateSplitList[0]}'));
    List<String> mockDate = dateSplitList.sublist(0, 3) +
        [dateWeekDay] +
        [dateSplitList[3].padLeft(2, '0')] +
        [dateSplitList[4].padLeft(2, '0')] +
        [dateSplitList[5]];

    String dateTimeIn24 = DateFormat('HH:mm').format(
        DateFormat(twelveHourTimeFormat).parse(mockDate.sublist(4).join('-')));
    int dateInMilliSeconds = DateTime.parse(
            '${mockDate[2]}-${getMonthNumber(mockDate[1]).toString().padLeft(2, '0')}-${mockDate[0]} $dateTimeIn24:00')
        .millisecondsSinceEpoch;

    return InboxSmsMessage(
        dateInMilliSeconds, mockDate, smsAddress, json['body'] as String);
  }
}
