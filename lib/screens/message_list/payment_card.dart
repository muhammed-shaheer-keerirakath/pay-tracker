import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/image_constants.dart';
import 'package:pay_tracker/screens/message_list/payment_card_content.dart';
import 'package:pay_tracker/screens/transactions_list/transactions_list.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/displayed_sms.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.cardMessages});
  final List<DisplayedSms> cardMessages;

  @override
  Widget build(BuildContext context) {
    String heroTag = UniqueKey().toString();
    String themeModeIdentifier =
        (Theme.of(context).brightness == Brightness.dark) ? '_dark' : '_light';
    String currencyName = cardMessages[0].currencyName;
    double totalAmountSpent = cardMessages
        .map((e) => e.currencyValue)
        .reduce((value, element) => value + element);
    String cardSpent = '$currencyName ${totalAmountSpent.toStringAsFixed(2)}';
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
                  availableAmount: cardMessages[0].availableAmount,
                  balanceType: cardMessages[0].balanceType,
                  cardImageUri: cardImageUri,
                  cardMessages: cardMessages,
                  cardNumber: cardNumber,
                  cardSpent: cardSpent,
                  cardType: cardType,
                  currencyName: currencyName,
                  heroTag: heroTag,
                  totalAmountSpent: totalAmountSpent,
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
              availableAmount: cardMessages[0].availableAmount,
              balanceType: cardMessages[0].balanceType,
              cardNumber: cardNumber,
              cardSpent: cardSpent,
              cardType: cardType,
              openedView: false,
              totalAmountSpent: totalAmountSpent,
              totalNumberOfTransactions: totalNumberOfTransactions,
              totalTransactions: totalTransactions,
            ),
          ),
        ),
      ),
    );
  }
}
