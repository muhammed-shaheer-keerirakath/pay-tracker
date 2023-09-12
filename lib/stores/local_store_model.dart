import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/identifier_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStoreModel extends ChangeNotifier {
  final Map<String, int> _dailyCardLimits = {};

  String _generateCardSignature(String cardType, String cardNumber) {
    return '$cardLimitKey$cardType$cardNumber';
  }

  Future<void> loadCardLimits(
      Map<String, List<String>> cardTypesAndNumbers) async {
    final preferences = await SharedPreferences.getInstance();
    cardTypesAndNumbers.forEach(
      (cardType, cardNumbers) {
        for (var cardNumber in cardNumbers) {
          String cardSignature = _generateCardSignature(cardType, cardNumber);
          _dailyCardLimits[cardSignature] =
              preferences.getInt(cardSignature) ?? 0;
        }
      },
    );
    notifyListeners();
  }

  Future<void> saveCardLimit(
      String cardType, String cardNumber, int limit) async {
    final preferences = await SharedPreferences.getInstance();
    String cardSignature = _generateCardSignature(cardType, cardNumber);
    preferences.setInt(cardSignature, limit);
    _dailyCardLimits[cardSignature] = limit;
    notifyListeners();
  }

  int getCardLimit(String cardType, String cardNumber) {
    String cardSignature = _generateCardSignature(cardType, cardNumber);
    return _dailyCardLimits[cardSignature] ?? 0;
  }
}
