import 'package:flutter/material.dart';

class PaymentCardContent extends StatelessWidget {
  const PaymentCardContent({
    super.key,
    required this.openedView,
    required this.cardSpent,
    required this.cardBalance,
    required this.cardNumber,
    required this.totalNumberOfTransactions,
    required this.totalTransactions,
  });
  final bool openedView;
  final String cardSpent;
  final String cardBalance;
  final String cardNumber;
  final int totalNumberOfTransactions;
  final String totalTransactions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  cardSpent,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(' total spent'),
              ]),
          const SizedBox(height: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(cardBalance),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardNumber,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        totalNumberOfTransactions.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(totalTransactions),
                      if (openedView)
                        const Icon(
                          Icons.keyboard_double_arrow_down_outlined,
                        ),
                      if (!openedView)
                        const Icon(
                          Icons.trending_flat,
                        )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
