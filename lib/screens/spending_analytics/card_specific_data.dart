import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/spending_analytics/card_specific_data_row.dart';

class CardSpecificData extends StatelessWidget {
  const CardSpecificData({
    required this.cardsMonthlyCurrencyValues,
    required this.cardType,
    super.key,
  });

  final Map<String, double> cardsMonthlyCurrencyValues;
  final String cardType;

  @override
  Widget build(BuildContext context) {
    if (cardsMonthlyCurrencyValues.isEmpty) {
      return Container();
    }

    List<Widget> cardDataList = [
      const SizedBox(
        height: 8,
      ),
    ];
    cardsMonthlyCurrencyValues.forEach((cardNumber, cardPaymentCurrencyValue) {
      cardDataList.add(
        CardSpecificDataRow(
          cardNumber: cardNumber,
          cardPaymentCurrencyValue: cardPaymentCurrencyValue,
          cardType: cardType,
        ),
      );
    });
    return Column(
      children: cardDataList,
    );
  }
}
