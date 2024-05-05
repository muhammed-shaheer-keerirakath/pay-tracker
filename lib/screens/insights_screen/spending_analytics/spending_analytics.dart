import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/insights_screen/spending_analytics/card_specific_data/card_specific_data.dart';
import 'package:pay_tracker/screens/insights_screen/spending_analytics/spending_on_item/spend_on_item.dart';
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
    MonthlySpending monthlySpending = messageStoreModel
        .getMonthlySpending(messageStoreModel.selectedMonthAndYear);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      child: Card(
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
                    '${messageStoreModel.selectedMonthAndYear} Analytics',
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
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 8, 8, 8),
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
                                      itemCount:
                                          messageStoreModel.yearsList.length,
                                      itemBuilder: (context, index) {
                                        String year =
                                            messageStoreModel.yearsList[index];
                                        return ExpansionTile(
                                            expandedAlignment:
                                                Alignment.topLeft,
                                            title: Text(year),
                                            initiallyExpanded: true,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 16),
                                                child: Wrap(
                                                  alignment:
                                                      WrapAlignment.start,
                                                  spacing: 6,
                                                  children: messageStoreModel
                                                      .monthsList
                                                      .where((month) =>
                                                          month.contains(year))
                                                      .map((monthAndYear) {
                                                    if (messageStoreModel
                                                            .selectedMonthAndYear ==
                                                        monthAndYear) {
                                                      return FilledButton(
                                                        child:
                                                            Text(monthAndYear),
                                                        onPressed: () {},
                                                      );
                                                    }
                                                    return OutlinedButton(
                                                      child: Text(monthAndYear),
                                                      onPressed: () {
                                                        setState(() {
                                                          messageStoreModel
                                                                  .selectedMonthAndYear =
                                                              monthAndYear;
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    );
                                                  }).toList(),
                                                ),
                                              )
                                            ]);
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
                      currencyValue: monthlySpending.creditCardsTotalSpending,
                      icon: Icons.credit_card,
                      title: 'On Credit'),
                  SpendOnItem(
                      currencyValue: monthlySpending.debitCardsTotalSpending,
                      icon: Icons.credit_card,
                      title: 'On Debit'),
                  SpendOnItem(
                      currencyValue: monthlySpending.totalSpending,
                      icon: Icons.money,
                      title: 'Total'),
                ],
              ),
              CardSpecificData(
                cardType: CardType.creditCard,
                cardsMonthlyCurrencyValues:
                    monthlySpending.creditCardsMonthlyCurrencyValues,
              ),
              CardSpecificData(
                cardType: CardType.debitCard,
                cardsMonthlyCurrencyValues:
                    monthlySpending.debitCardsMonthlyCurrencyValues,
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
