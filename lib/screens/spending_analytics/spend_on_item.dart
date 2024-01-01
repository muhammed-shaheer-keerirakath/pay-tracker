import 'package:flutter/material.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:provider/provider.dart';

class SpendOnItem extends StatelessWidget {
  const SpendOnItem({
    required this.currencyValue,
    required this.icon,
    required this.title,
    super.key,
  });
  final double currencyValue;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);

    return Row(children: [
      Icon(
        icon,
        size: 18,
      ),
      const SizedBox(
        width: 6,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
        ),
        Text(
          '${messageStoreModel.currencyName} ${currencyValue.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    ]);
  }
}
