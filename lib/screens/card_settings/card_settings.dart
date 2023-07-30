import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';

class CardSettings extends StatefulWidget {
  const CardSettings({
    super.key,
    required this.currencyName,
    required this.cardNumber,
  });
  final String currencyName;
  final String cardNumber;

  @override
  State<CardSettings> createState() => _CardSettingsState();
}

class _CardSettingsState extends State<CardSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitleCardSettings),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 7,
                    child: Text('Daily Limit'),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        border: OutlineInputBorder(),
                        hintText: 'Limit',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(widget.currencyName),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
