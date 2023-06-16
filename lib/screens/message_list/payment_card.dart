import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/screens/message_list/payment_card_content.dart';
import 'package:pay_tracker/screens/transactions_list/transactions_list.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/displayed_sms.dart';
import 'package:pay_tracker/utilities/shared/shared_utilities.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.cardMessages});
  final List<DisplayedSms> cardMessages;

  @override
  Widget build(BuildContext context) {
    String heroTag = UniqueKey().toString();
    String themeModeIdentifier = getThemeModeIdentifier(context);
    String cardSpent =
        '${cardMessages[0].currencyName} ${cardMessages.map((e) => e.currencyValue).reduce((value, element) => value + element).toStringAsFixed(2)}';
    String cardBalance =
        'Current ${cardMessages[0].balanceType} is ${cardMessages[0].availableAmount}';
    String cardType = cardMessages[0].cardType;
    String cardNumber = cardMessages[0].cardNumber;
    int totalNumberOfTransactions = cardMessages.length;
    String totalTransactions =
        ' transaction${totalNumberOfTransactions > 1 ? 's' : ''}';
    String cardImageUri = (cardType == CardType.creditCard)
        ? creditCardCoverImageUri
        : debitCardCoverImageUri;

    return Hero(
      tag: heroTag,
      child: Card(
        elevation: 12,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionsList(
                  heroTag: heroTag,
                  cardImageUri: cardImageUri,
                  cardMessages: cardMessages,
                  cardSpent: cardSpent,
                  cardBalance: cardBalance,
                  cardType: cardType,
                  cardNumber: cardNumber,
                  totalNumberOfTransactions: totalNumberOfTransactions,
                  totalTransactions: totalTransactions,
                ),
              ),
            );
          },
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  '$cardImageUri$themeModeIdentifier$cardCoverFileType',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: PaymentCardContent(
              openedView: false,
              cardSpent: cardSpent,
              cardBalance: cardBalance,
              cardType: cardType,
              cardNumber: cardNumber,
              totalNumberOfTransactions: totalNumberOfTransactions,
              totalTransactions: totalTransactions,
            ),
          ),
        ),
      ),
    );
  }
}
