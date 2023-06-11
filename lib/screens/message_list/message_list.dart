import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/message_list/payment_card.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messages});
  final List<DateGroupedSms> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(children: [
                    Text(
                      messages[index].date,
                    ),
                  ]),
                  messages[index].creditCards.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            PaymentCard(
                                cardType: CardType.creditCard,
                                cardMessages: messages[index].creditCards),
                          ],
                        )
                      : const SizedBox(width: 0, height: 0),
                  messages[index].debitCards.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            PaymentCard(
                              cardType: CardType.debitCard,
                              cardMessages: messages[index].debitCards,
                            ),
                          ],
                        )
                      : const SizedBox(width: 0, height: 0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
