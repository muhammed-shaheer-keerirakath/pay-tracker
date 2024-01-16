import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:provider/provider.dart';

class PaymentCardContent extends StatelessWidget {
  const PaymentCardContent({
    required this.availableAmount,
    required this.balanceType,
    required this.cardNumber,
    required this.cardSpent,
    required this.cardType,
    required this.openedView,
    required this.totalAmountSpent,
    required this.totalNumberOfTransactions,
    required this.totalTransactions,
    super.key,
  });
  final bool openedView;
  final double totalAmountSpent;
  final int totalNumberOfTransactions;
  final String availableAmount;
  final String balanceType;
  final String cardNumber;
  final String cardSpent;
  final String cardType;
  final String totalTransactions;

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    int dailyCardLimit = messageStoreModel.getCardLimit(cardType, cardNumber);
    double percentageConsumed = (totalAmountSpent / dailyCardLimit * 100);

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
                  const TextSpan(
                    text: 'Current ',
                  ),
                  TextSpan(
                    text: balanceType,
                  ),
                  const TextSpan(
                    text: ' is ',
                  ),
                  TextSpan(
                    text: availableAmount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        if (dailyCardLimit != 0)
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          const TextSpan(
                            text: 'Consumed: ',
                          ),
                          TextSpan(
                            text:
                                '${(min(percentageConsumed, 100)).toStringAsFixed(0)}%',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: LinearProgressIndicator(
                        value: totalAmountSpent / dailyCardLimit,
                        semanticsLabel: 'Daily limit indicator',
                        backgroundColor: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                ],
              ),
              if (percentageConsumed > 100)
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            const TextSpan(
                              text: 'Overspent: ',
                            ),
                            TextSpan(
                              text:
                                  '${(percentageConsumed - 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6)),
                        child: LinearProgressIndicator(
                          value: (percentageConsumed - 100) / 100,
                          semanticsLabel: 'Daily limit indicator',
                          backgroundColor:
                              Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                  ],
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
