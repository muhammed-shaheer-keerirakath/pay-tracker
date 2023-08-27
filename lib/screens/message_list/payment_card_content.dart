import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/identifier_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentCardContent extends StatefulWidget {
  const PaymentCardContent({
    super.key,
    required this.openedView,
    required this.cardSpent,
    required this.cardBalance,
    required this.cardType,
    required this.cardNumber,
    required this.totalAmountSpent,
    required this.totalNumberOfTransactions,
    required this.totalTransactions,
  });
  final bool openedView;
  final String cardSpent;
  final String cardBalance;
  final String cardType;
  final String cardNumber;
  final double totalAmountSpent;
  final int totalNumberOfTransactions;
  final String totalTransactions;

  @override
  State<PaymentCardContent> createState() => _PaymentCardContentState();
}

class _PaymentCardContentState extends State<PaymentCardContent> {
  int dailyLimit = 0;
  double percentageConsumed = 0;
  Future<void> _loadCardLimit() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      dailyLimit = (preferences
              .getInt('$cardLimitKey${widget.cardType}${widget.cardNumber}') ??
          0);
      percentageConsumed = (widget.totalAmountSpent / dailyLimit * 100);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCardLimit();
  }

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
                    text: widget.cardSpent,
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
                    text: widget.cardBalance,
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(child: Container()),
        if (dailyLimit != 0)
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
                        value: widget.totalAmountSpent / dailyLimit,
                        semanticsLabel: 'Daily limit indicator',
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
                    text: widget.cardType,
                  ),
                  const TextSpan(
                    text: ' XXXX ',
                  ),
                  TextSpan(
                    text: widget.cardNumber,
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
                    text: widget.totalNumberOfTransactions.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: widget.totalTransactions,
                  ),
                  if (widget.openedView)
                    const WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Icon(
                        Icons.keyboard_double_arrow_down_outlined,
                      ),
                    ),
                  if (!widget.openedView)
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
