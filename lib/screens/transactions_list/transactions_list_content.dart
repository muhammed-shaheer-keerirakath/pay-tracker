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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    '${cardMessage.hour}:${cardMessage.minute} ${cardMessage.amPm}',
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                cardMessage.purchasedAt,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: '${cardMessage.balanceType}: ',
                        ),
                        TextSpan(
                          text: cardMessage.availableAmount,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
