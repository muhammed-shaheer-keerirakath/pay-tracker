import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/date_constants.dart';
import 'package:pay_tracker/screens/spending_analytics/card_specific_data.dart';
import 'package:pay_tracker/screens/spending_analytics/spend_on_item.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/monthly_spending.dart';
import 'package:provider/provider.dart';

class SpendingAnalytics extends StatefulWidget {
  const SpendingAnalytics({super.key});

  @override
  State<SpendingAnalytics> createState() => _SpendingAnalyticsState();
}

class _SpendingAnalyticsState extends State<SpendingAnalytics> {
  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    MonthlySpending monthlySpending =
        messageStoreModel.getMonthlySpending(messageStoreModel.currentMonth);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        '${messageStoreModel.currentMonth} ${messageStoreModel.currentYear} Analytics',
                      ),
                      FilledButton.icon(
                          label: const Text('Change Month'),
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor:
                                  Theme.of(context).colorScheme.background,
                              context: context,
                              builder: (BuildContext buildContext) {
                                return SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 8, 8, 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Select Month',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.close),
                                              onPressed: () =>
                                                  Navigator.pop(buildContext),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: 12,
                                          itemBuilder: (context, index) {
                                            bool isCurrentSelection =
                                                (messageStoreModel
                                                        .currentMonth ==
                                                    monthsMMMFormat[index]);

                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  messageStoreModel
                                                          .currentMonth =
                                                      monthsMMMFormat[index];
                                                });
                                                Navigator.pop(buildContext);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 16,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      '${monthsMMMFormat[index]} ${messageStoreModel.currentYear}',
                                                    ),
                                                    if (isCurrentSelection)
                                                      const Icon(
                                                        Icons.done,
                                                      )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.calendar_month))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SpendOnItem(
                          currencyValue:
                              monthlySpending.creditCardsTotalSpending,
                          currencyName: monthlySpending.currencyName,
                          icon: Icons.credit_card,
                          title: 'On Credit'),
                      SpendOnItem(
                          currencyValue:
                              monthlySpending.debitCardsTotalSpending,
                          currencyName: monthlySpending.currencyName,
                          icon: Icons.credit_card,
                          title: 'On Debit'),
                      SpendOnItem(
                          currencyValue: monthlySpending.totalSpending,
                          currencyName: monthlySpending.currencyName,
                          icon: Icons.money,
                          title: 'Total'),
                    ],
                  ),
                  CardSpecificData(
                    cardType: CardType.creditCard,
                    cardsMonthlyCurrencyValues:
                        monthlySpending.creditCardsMonthlyCurrencyValues,
                    currencyName: monthlySpending.currencyName,
                  ),
                  CardSpecificData(
                    cardType: CardType.debitCard,
                    cardsMonthlyCurrencyValues:
                        monthlySpending.debitCardsMonthlyCurrencyValues,
                    currencyName: monthlySpending.currencyName,
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard_double_arrow_down_outlined),
                Text('Your transactions from past 10 days'),
                Icon(Icons.keyboard_double_arrow_down_outlined),
              ],
            ),
          )
        ],
      ),
    );
  }
}
