import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/stores/local_store_model.dart';
import 'package:provider/provider.dart';

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
  late TextEditingController _cardLimitController;

  void goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    final LocalStoreModel localStoreModel =
        Provider.of<LocalStoreModel>(context, listen: false);
    super.initState();
    _cardLimitController = TextEditingController(
        text: localStoreModel
            .getCardLimit(widget.cardType, widget.cardNumber)
            .toString());
  }

  @override
  void dispose() {
    _cardLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LocalStoreModel localStoreModel =
        Provider.of<LocalStoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitleCardSettings),
      ),
      body: Padding(
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
                    controller: _cardLimitController,
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
                onPressed: () async {
                  await localStoreModel.saveCardLimit(
                      widget.cardType,
                      widget.cardNumber,
                      int.parse(_cardLimitController.text.isNotEmpty
                          ? _cardLimitController.text
                          : "0"));
                  goBack();
                },
                icon: const Icon(Icons.save),
                label: const Text("Save and Close"))
          ],
        ),
      ),
    );
  }
}
