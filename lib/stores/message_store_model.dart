import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';
import 'package:pay_tracker/types/displayed_sms.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';
import 'package:pay_tracker/types/monthly_analytics.dart';
import 'package:pay_tracker/types/monthly_spending.dart';
import 'package:pay_tracker/utilities/readers/message_reader.dart';

class MessageStoreModel extends ChangeNotifier {
  Exception exception = Exception('');
  bool smsPermissionFailed = false;
  bool exceptionOccurred = false;
  final List<DateGroupedSms> _dateGroupedSms = [];
  final Map<String, List<String>> _cardTypesAndNumbers = {};
  late MonthlyAnalytics _monthlyAnalytics;

  MessageStoreModel() {
    fetchMessagesFromInbox();
  }

  String get currentYear => _monthlyAnalytics.currentYear;

  String get currentMonth => _monthlyAnalytics.currentMonth;

  set currentMonth(String month) => _monthlyAnalytics.currentMonth = month;

  String get currentDay => _monthlyAnalytics.currentDay;

  List<DateGroupedSms> get groupedMessages => _dateGroupedSms;

  Map<String, List<String>> get cardTypesAndNumbers => _cardTypesAndNumbers;

  MonthlySpending getMonthlySpending(String month) {
    MonthlySpending? monthlySpending = _monthlyAnalytics.monthlySpending[month];
    if (monthlySpending != null) {
      return monthlySpending;
    } else {
      return MonthlySpending.empty();
    }
  }

  void _generateMonthlyAnalytics() {
    _monthlyAnalytics = MonthlyAnalytics(_dateGroupedSms);
  }

  void _addGroupedSms(DateGroupedSms dateGroupedSms) {
    _dateGroupedSms.add(dateGroupedSms);
  }

  void _clearGroupedSms() {
    _dateGroupedSms.clear();
  }

  Future<void> fetchMessagesFromInbox() async {
    List<InboxSmsMessage> inboxMessages = [];
    try {
      inboxMessages = await getInboxMessages();
    } on PlatformException {
      smsPermissionFailed = true;
    } on Exception catch (e) {
      exceptionOccurred = true;
      exception = e;
    }
    if (smsPermissionFailed || exceptionOccurred) return;
    addInboxMessagesToStore(inboxMessages);
    // await localStoreModel.loadCardLimits(messageStoreModel.cardTypesAndNumbers);
    notifyListeners();
  }

  void addInboxMessagesToStore(List<InboxSmsMessage> inboxMessages) async {
    _clearGroupedSms();
    List<DisplayedSms> displayedSms = [];
    for (var inboxMessage in inboxMessages) {
      RegExpMatch? regexMatch = regExp.firstMatch(inboxMessage.body);
      if (regexMatch != null) {
        DisplayedSms displayedSmsObject =
            DisplayedSms(regexMatch, inboxMessage);
        displayedSms.add(displayedSmsObject);
        if (_cardTypesAndNumbers.containsKey(displayedSmsObject.cardType)) {
          if (!(_cardTypesAndNumbers[displayedSmsObject.cardType]
                  ?.contains(displayedSmsObject.cardNumber) ??
              false)) {
            _cardTypesAndNumbers[displayedSmsObject.cardType]
                ?.add(displayedSmsObject.cardNumber);
          }
        } else {
          _cardTypesAndNumbers[displayedSmsObject.cardType] = [
            displayedSmsObject.cardNumber
          ];
        }
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
    _generateMonthlyAnalytics();
  }
}
