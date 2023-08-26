import 'package:flutter/material.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';

class MessageStoreModel extends ChangeNotifier {
  final List<DateGroupedSms> _dateGroupedSms = [];

  List<DateGroupedSms> get groupedMessages => _dateGroupedSms;

  void addGroupedSms(DateGroupedSms dateGroupedSms) {
    _dateGroupedSms.add(dateGroupedSms);
    notifyListeners();
  }

  void clearGroupedSms() {
    _dateGroupedSms.clear();
    notifyListeners();
  }
}
