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
    preferences.setInt(
        '$cardLimitKey${widget.cardType}${widget.cardNumber}',
        cardLimitController.text.isNotEmpty
            ? int.parse(cardLimitController.text)
            : 0);
  }

  Future<void> _loadCardLimit() async {
    final preferences = await SharedPreferences.getInstance();
    cardLimitController.text = (preferences.getInt(
                '$cardLimitKey${widget.cardType}${widget.cardNumber}') ??
            0)
        .toString();
    await Future.delayed(const Duration(milliseconds: 100), () {});
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
      body: FutureBuilder(
        future: _loadCardLimit(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LinearProgressIndicator();
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                FilledButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(
                          40), // fromHeight use double.infinity as width and 40 is the height
                    ),
                    onPressed: () {
                      _saveCardLimit();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save and Close"))
              ],
            ),
          );
        },
      ),
    );
  }
}
