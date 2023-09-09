import 'package:flutter/material.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
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
                height: 6,
              ),
              Text(
                  '${monthlySpending.currencyName} ${monthlySpending.creditCardsTotalSpending.toStringAsFixed(2)} spent on Credit Cards'),
              Text(
                  '${monthlySpending.currencyName} ${monthlySpending.debitCardsTotalSpending.toStringAsFixed(2)} spent on Debit Cards'),
              Text(
                  '${monthlySpending.currencyName} ${monthlySpending.totalSpending.toStringAsFixed(2)} spent in total'),
            ],
          ),
        ),
      ),
    );
  }
}
