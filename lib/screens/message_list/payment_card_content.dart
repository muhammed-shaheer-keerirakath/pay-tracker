import 'package:flutter/material.dart';

class PaymentCardContent extends StatelessWidget {
  const PaymentCardContent({
    super.key,
    required this.openedView,
    required this.cardSpent,
    required this.cardBalance,
    required this.cardType,
    required this.cardNumber,
    required this.totalNumberOfTransactions,
    required this.totalTransactions,
  });
  final bool openedView;
  final String cardSpent;
  final String cardBalance;
  final String cardType;
  final String cardNumber;
  final int totalNumberOfTransactions;
  final String totalTransactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: cardSpent,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(
                    text: ' total spent',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: cardBalance,
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: cardType,
                  ),
                  const TextSpan(
                    text: ' XXXX ',
                  ),
                  TextSpan(
                    text: cardNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: totalNumberOfTransactions.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: totalTransactions,
                  ),
                  if (openedView)
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.keyboard_double_arrow_down_outlined,
                      ),
                    ),
                  if (!openedView)
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.trending_flat,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
