import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/image_constants.dart';
import 'package:pay_tracker/screens/spending_analytics/data_row_item.dart';
import 'package:pay_tracker/stores/local_store_model.dart';
import 'package:provider/provider.dart';

class CardSpecificDataRow extends StatelessWidget {
  const CardSpecificDataRow({
    required this.cardNumber,
    required this.cardPaymentCurrencyValue,
    required this.cardType,
    required this.currencyName,
    super.key,
  });

  final double cardPaymentCurrencyValue;
  final String cardNumber;
  final String cardType;
  final String currencyName;

  @override
  Widget build(BuildContext context) {
    LocalStoreModel localStoreModel = Provider.of<LocalStoreModel>(context);
    int numberOfDaysInMonth = 31;
    int dailyCardLimit = localStoreModel.getCardLimit(cardType, cardNumber);
    int monthlyCardLimit = dailyCardLimit * numberOfDaysInMonth;
    double overSpent = cardPaymentCurrencyValue - monthlyCardLimit;

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
                    '${creditCardCoverImageUri}_light$cardCoverFileType',
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
                    title: 'Underspent',
                    data: '$currencyName ${overSpent.abs().toStringAsFixed(2)}',
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
