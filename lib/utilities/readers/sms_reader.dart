import 'package:intl/intl.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';
import 'package:telephony/telephony.dart';

Future<List<InboxSmsMessage>> getSmsMessages() async {
  List<SmsMessage> telephonyMessages = await Telephony.instance.getInboxSms(
    columns: [SmsColumn.DATE, SmsColumn.ADDRESS, SmsColumn.BODY],
    filter: SmsFilter.where(SmsColumn.ADDRESS)
        .equals(smsAddress)
        .and(SmsColumn.BODY)
        .like(smsLike),
    sortOrder: [
      OrderBy(SmsColumn.DATE, sort: Sort.DESC),
    ],
  );

  List<InboxSmsMessage> messages = [];
  for (var telephonyMessage in telephonyMessages) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(telephonyMessage.date ?? 0);
    List<String> formattedDate =
        DateFormat(cardDateGroupedFormat).format(dateTime).split('-');
    messages.add(InboxSmsMessage(formattedDate, telephonyMessage.address ?? '',
        telephonyMessage.body ?? ''));
  }
  return messages;
}
