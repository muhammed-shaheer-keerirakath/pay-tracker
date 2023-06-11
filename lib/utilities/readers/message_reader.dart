import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';
import 'package:pay_tracker/utilities/readers/json_reader.dart';
import 'package:pay_tracker/utilities/readers/sms_reader.dart';

Future<List<InboxSmsMessage>> getInboxMessages() async {
  return useMockData ? getJsonMessages() : getSmsMessages();
}
