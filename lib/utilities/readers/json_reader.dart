import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:pay_tracker/types/inbox_sms_message.dart';

Future<List<InboxSmsMessage>> getJsonMessages() async {
  final String jsonFileContents =
      await rootBundle.loadString('lib/assets/json/mock_messages.json');
  List<dynamic> decodedMessagesList = await json.decode(jsonFileContents);
  List<InboxSmsMessage> messages = [];
  for (var decodedMessage in decodedMessagesList) {
    messages.add(InboxSmsMessage.fromMockJson(decodedMessage));
  }
  messages.sort((a, b) => b.dateInMilliSeconds - a.dateInMilliSeconds);
  return messages;
}
