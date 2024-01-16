import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/image_constants.dart';
import 'package:pay_tracker/screens/spending_analytics/data_row_item.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/utilities/shared/shared_utilities.dart';
import 'package:provider/provider.dart';

class CardSpecificDataRow extends StatelessWidget {
  const CardSpecificDataRow({
    required this.cardNumber,
    required this.cardPaymentCurrencyValue,
    required this.cardType,
    super.key,
  });

  final double cardPaymentCurrencyValue;
  final String cardNumber;
  final String cardType;

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    String themeModeIdentifier =
        (Theme.of(context).brightness == Brightness.dark)
            ? ThemeModeIdentifier.dark
            : ThemeModeIdentifier.light;
    int currentYear = int.parse(messageStoreModel.year);
    int currentMonth = getMonthNumber(messageStoreModel.month);
    int currentDay = int.parse(messageStoreModel.day);
    int numberOfDaysInMonth = getDaysInMonth(currentYear, currentMonth);

    String currencyName = messageStoreModel.currencyName;
    int dailyCardLimit = messageStoreModel.getCardLimit(cardType, cardNumber);
    int monthlyCardLimit = dailyCardLimit * numberOfDaysInMonth;
    double overSpent = cardPaymentCurrencyValue - monthlyCardLimit;

    String cardCoverImage = messageStoreModel.getCardCoverImage(
        cardType, cardNumber, themeModeIdentifier);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: RotatedBox(
                quarterTurns: -1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    cardCoverImage,
                    height: 26,
                    width: 42,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DataRowItem(
                    title: cardType,
                    data: cardNumber,
                  ),
                  DataRowItem(
                    title: 'Monthly Limit',
                    data: '$currencyName ${monthlyCardLimit.toString()}',
                    secondaryData:
                        '($currencyName $dailyCardLimit for $numberOfDaysInMonth days)',
                    shouldHide: (dailyCardLimit <= 0),
                  ),
                  DataRowItem(
                    title: 'Spent',
                    data:
                        '$currencyName ${cardPaymentCurrencyValue.toStringAsFixed(2)}',
                    progressNumerator: cardPaymentCurrencyValue,
                    progressDinominator: monthlyCardLimit.toDouble(),
                  ),
                  DataRowItem(
                    title: 'Overspent',
                    data: '$currencyName ${overSpent.toStringAsFixed(2)}',
                    progressNumerator: overSpent,
                    progressDinominator: monthlyCardLimit.toDouble(),
                    shouldHide: (dailyCardLimit <= 0) || (overSpent <= 0),
                  ),
                  DataRowItem(
                    title: 'Remaining',
                    data: '$currencyName ${overSpent.abs().toStringAsFixed(2)}',
                    secondaryData:
                        '($currencyName ${(overSpent.abs() / (numberOfDaysInMonth - currentDay)).toStringAsFixed(2)} for ${numberOfDaysInMonth - currentDay} days)',
                    progressNumerator: overSpent.abs(),
                    progressDinominator: monthlyCardLimit.toDouble(),
                    shouldHide: (dailyCardLimit <= 0) || (overSpent >= 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
