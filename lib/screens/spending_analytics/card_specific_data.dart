import 'package:flutter/material.dart';

class CardSpecificData extends StatelessWidget {
  const CardSpecificData({
    required this.cardsMonthlyCurrencyValues,
    super.key,
  });
  final Map<String, double> cardsMonthlyCurrencyValues;

  @override
  Widget build(BuildContext context) {
    List<Row> cardDataList = [];
    cardsMonthlyCurrencyValues.forEach((cardNumber, cardPaymentCurrencyValue) {
      cardDataList.add(Row(
        children: [
          Text(
            cardNumber,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            cardPaymentCurrencyValue.toStringAsFixed(2),
          )
        ],
      ));
    });
    return Column(
      children: cardDataList,
    );
  }
}
