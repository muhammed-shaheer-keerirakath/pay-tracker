import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';
import 'package:pay_tracker/types/displayed_sms.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';

class MessageStoreModel extends ChangeNotifier {
  final List<DateGroupedSms> _dateGroupedSms = [];

  void _addGroupedSms(DateGroupedSms dateGroupedSms) {
    _dateGroupedSms.add(dateGroupedSms);
  }

  void _clearGroupedSms() {
    _dateGroupedSms.clear();
  }

  Future<void> addInboxMessagesToStore(
      List<InboxSmsMessage> inboxMessages) async {
    _clearGroupedSms();
    List<DisplayedSms> displayedSms = [];
    for (var inboxMessage in inboxMessages) {
      RegExpMatch? regexMatch = regExp.firstMatch(inboxMessage.body);
      if (regexMatch != null) {
        displayedSms.add(DisplayedSms(regexMatch, inboxMessage));
      }
    }
    String? dateStamp = displayedSms.isNotEmpty
        ? displayedSms[0].dateTime.toString().substring(0, 10)
        : null;
    List<DisplayedSms> dateStampMessages =
        displayedSms.isNotEmpty ? [displayedSms[0]] : [];
    for (var i = 1; i < displayedSms.length; i++) {
      DisplayedSms sms = displayedSms[i];
      String currentDateStamp = sms.dateTime.toString().substring(0, 10);
      if (dateStamp == currentDateStamp) {
        dateStampMessages.add(sms);
      } else {
        _addGroupedSms(DateGroupedSms(dateStampMessages));
        dateStamp = currentDateStamp;
        dateStampMessages = [sms];
      }
    }
    if (dateStampMessages.isNotEmpty) {
      _addGroupedSms(DateGroupedSms(dateStampMessages));
    }
    notifyListeners();
  }

  List<DateGroupedSms> get groupedMessages => _dateGroupedSms;
}
