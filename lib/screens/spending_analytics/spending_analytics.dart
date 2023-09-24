import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/spending_analytics/card_specific_data.dart';
import 'package:pay_tracker/screens/spending_analytics/spend_on_item.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/card_type.dart';
import 'package:pay_tracker/types/monthly_spending.dart';
import 'package:provider/provider.dart';

class SpendingAnalytics extends StatelessWidget {
  const SpendingAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    MonthlySpending monthlySpending = messageStoreModel.getMonthlySpending();

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
              Text(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  '${monthlySpending.currentMonth} ${monthlySpending.currentYear} Analytics'),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpendOnItem(
                      currencyValue: monthlySpending.creditCardsTotalSpending,
                      currencyName: monthlySpending.currencyName,
                      icon: Icons.credit_card,
                      title: 'On Credit'),
                  SpendOnItem(
                      currencyValue: monthlySpending.debitCardsTotalSpending,
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
              ),
              CardSpecificData(
                cardType: CardType.debitCard,
                cardsMonthlyCurrencyValues:
                    monthlySpending.debitCardsMonthlyCurrencyValues,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
