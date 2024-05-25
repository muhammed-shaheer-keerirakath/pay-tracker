import 'package:pay_tracker/types/date_grouped_sms.dart';

class PlacesSpent {
  /// eg: [ "Dubai Mall", "Emirates" ]
  late List<String> mostSpentPlaces = [];

  /// eg: { "Dubai Mall":PlacesSpentData }
  late Map<String, double> spentPlaces = {};

  PlacesSpent.empty();

  PlacesSpent(
      Map<String, List<DateGroupedSms>> yearlySpending, String monthAndYear) {
    yearlySpending[monthAndYear]?.forEach((dateGroupedMessage) {
      dateGroupedMessage.creditCards.forEach((cardNumber, cardPayments) {
        for (var displayedSms in cardPayments) {}
      });
    });
  }
}
