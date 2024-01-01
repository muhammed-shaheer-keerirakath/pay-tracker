import 'package:pay_tracker/constants/sms_reader_constants.dart';

class InboxSmsMessage {
  late List<String> date;
  late String address;
  late String body;

  InboxSmsMessage(this.date, this.address, this.body);

  factory InboxSmsMessage.fromMockJson(dynamic json) {
    String date = json['date'] as String;
    return InboxSmsMessage(date.split('-'), smsAddress, json['body'] as String);
  }
}
