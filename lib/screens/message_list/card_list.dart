import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/message_list/payment_card.dart';
import 'package:pay_tracker/types/displayed_sms.dart';

class CardList extends StatelessWidget {
  const CardList({
    super.key,
    required this.cards,
  });
  final Map<String, List<DisplayedSms>> cards;

  @override
  Widget build(BuildContext context) {
    List<Column> cardList = [];
    cards.forEach((cardNumber, cardPayments) {
      cardList.add(Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          PaymentCard(
            cardMessages: cardPayments,
          ),
        ],
      ));
    });
    return Column(children: cardList);
  }
}
