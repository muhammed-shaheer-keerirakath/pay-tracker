import 'package:flutter/material.dart';

class SpendOnItem extends StatelessWidget {
  const SpendOnItem({
    required this.currencyName,
    required this.currencyValue,
    required this.icon,
    required this.title,
    super.key,
  });
  final double currencyValue;
  final IconData icon;
  final String currencyName;
  final String title;

  @override
  Widget build(BuildContext context) {
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
          '$currencyName ${currencyValue.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    ]);
  }
}
