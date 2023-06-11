import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/screens/message_list/payment_card_content.dart';
import 'package:pay_tracker/screens/transactions_list/transactions_list_content.dart';
import 'package:pay_tracker/types/displayed_sms.dart';
import 'package:pay_tracker/utilities/shared/shared_utilities.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.heroTag,
    required this.cardImageUri,
    required this.cardMessages,
    required this.cardSpent,
    required this.cardBalance,
    required this.cardNumber,
    required this.totalNumberOfTransactions,
    required this.totalTransactions,
  });
  final String heroTag;
  final String cardImageUri;
  final List<DisplayedSms> cardMessages;
  final String cardSpent;
  final String cardBalance;
  final String cardNumber;
  final int totalNumberOfTransactions;
  final String totalTransactions;

  @override
  Widget build(BuildContext context) {
    String themeModeIdentifier = getThemeModeIdentifier(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
            child: Hero(
              tag: heroTag,
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        '$cardImageUri$themeModeIdentifier$cardCoverFileType',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: PaymentCardContent(
                    openedView: true,
                    cardSpent: cardSpent,
                    cardBalance: cardBalance,
                    cardNumber: cardNumber,
                    totalNumberOfTransactions: totalNumberOfTransactions,
                    totalTransactions: totalTransactions,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '${cardMessages[0].weekday}, ${cardMessages[0].day} ${cardMessages[0].month} ${cardMessages[0].year}',
          ),
          const SizedBox(height: 12),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cardMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionsListContent(
                  cardMessage: cardMessages[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
