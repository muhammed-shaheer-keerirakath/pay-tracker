import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/image_constants.dart';
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
          children: [
            RotatedBox(
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
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$cardType ',
                      ),
                      Text(
                        cardNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Spent ',
                      ),
                      Text(
                        '$currencyName ${cardPaymentCurrencyValue.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if ((cardPaymentCurrencyValue > 0) &&
                          (dailyCardLimit > 0))
                        Expanded(
                          flex: 2,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: LinearProgressIndicator(
                              value:
                                  monthlyCardLimit / cardPaymentCurrencyValue,
                              semanticsLabel: 'Monthly limit indicator',
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (dailyCardLimit > 0)
                    Row(
                      children: [
                        const Text(
                          'Limit ',
                        ),
                        Text(
                          '$currencyName ${monthlyCardLimit.toString()} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '($currencyName $dailyCardLimit for $numberOfDaysInMonth days)',
                        ),
                      ],
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
