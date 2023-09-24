import 'package:flutter/material.dart';

class CardSpecificDataRow extends StatelessWidget {
  const CardSpecificDataRow({
    required this.cardNumber,
    required this.cardPaymentCurrencyValue,
    required this.cardType,
    super.key,
  });

  final double cardPaymentCurrencyValue;
  final String cardNumber;
  final String cardType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              '$cardType ',
            ),
            Text(
              '$cardNumber: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              cardPaymentCurrencyValue.toStringAsFixed(2),
            )
          ],
        ),
      ),
    );
  }
}
