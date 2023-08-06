import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/constants/identifier_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardSettings extends StatefulWidget {
  const CardSettings({
    super.key,
    required this.cardType,
    required this.currencyName,
    required this.cardNumber,
  });
  final String cardType;
  final String currencyName;
  final String cardNumber;

  @override
  State<CardSettings> createState() => _CardSettingsState();
}

class _CardSettingsState extends State<CardSettings> {
  final cardLimitController = TextEditingController();

  Future<void> _saveCardLimit() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt(
          '$cardLimitKey${widget.cardType}${widget.cardNumber}',
          cardLimitController.text.isNotEmpty
              ? int.parse(cardLimitController.text)
              : 0);
    });
  }

  Future<void> _loadCardLimit() async {
    final preferences = await SharedPreferences.getInstance();
    setState(() {
      cardLimitController.text = (preferences.getInt(
                  '$cardLimitKey${widget.cardType}${widget.cardNumber}') ??
              0)
          .toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCardLimit();
  }

  @override
  void dispose() {
    cardLimitController.dispose();
    super.dispose();
  }

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
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: cardLimitController,
                      onChanged: (value) => {_saveCardLimit()},
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
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
