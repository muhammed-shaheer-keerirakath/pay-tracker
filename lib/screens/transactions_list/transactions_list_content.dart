import 'package:flutter/material.dart';
import 'package:pay_tracker/types/displayed_sms.dart';

class TransactionsListContent extends StatelessWidget {
  const TransactionsListContent({super.key, required this.cardMessage});
  final DisplayedSms cardMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    cardMessage.purchasedAmount,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${cardMessage.hour}:${cardMessage.minute} ${cardMessage.amPm}',
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                cardMessage.purchasedAt,
              ),
              const SizedBox(height: 6),
              Text(
                '${cardMessage.balanceType}: ${cardMessage.availableAmount}',
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
