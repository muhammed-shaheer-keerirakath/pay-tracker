import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/constants/image_constants.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:provider/provider.dart';

class CardSettings extends StatefulWidget {
  const CardSettings({
    super.key,
    required this.cardType,
    required this.cardNumber,
  });
  final String cardType;
  final String cardNumber;

  @override
  State<CardSettings> createState() => _CardSettingsState();
}

class _CardSettingsState extends State<CardSettings> {
  late TextEditingController _cardLimitController;
  String selectedCardCoverImageIdentifier = "";

  void goBack() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    final MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context, listen: false);
    _cardLimitController = TextEditingController(
        text: messageStoreModel
            .getCardLimit(widget.cardType, widget.cardNumber)
            .toString());
    selectedCardCoverImageIdentifier = messageStoreModel.getCardCoverImage(
        widget.cardType, widget.cardNumber, null,
        onlyCardCoverImageIdentifier: true);
    super.initState();
  }

  @override
  void dispose() {
    _cardLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    String currencyName = messageStoreModel.currencyName;

    String themeModeIdentifier =
        (Theme.of(context).brightness == Brightness.dark)
            ? ThemeModeIdentifier.dark
            : ThemeModeIdentifier.light;

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor:
              Theme.of(context).colorScheme.surface, // Navigation bar
        ),
        title: const Text(appTitleCardSettings),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(children: [
                        Text(
                          'Card Details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      const SizedBox(
                        height: 6,
                      ),
                      Text('${widget.cardType} XXXX ${widget.cardNumber}')
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(children: [
                        Text(
                          'Spending Limit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Expanded(
                            flex: 7,
                            child: Text('Daily Limit Target'),
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 8, 12, 8),
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
                            child: Text(currencyName),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Row(children: [
                        Text(
                          'Card Cover Image',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      const SizedBox(
                        height: 12,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: cardCoverImageIdentifier.length,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 1,
                                mainAxisExtent: 100),
                        itemBuilder:
                            (BuildContext gridViewContext, int gridViewIndex) {
                          String currentCardCoverImageIdentifier =
                              cardCoverImageIdentifier[gridViewIndex];
                          return Stack(
                            children: [
                              Ink.image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  '$cardCoverPath$currentCardCoverImageIdentifier$themeModeIdentifier$cardCoverFileType',
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedCardCoverImageIdentifier =
                                          currentCardCoverImageIdentifier;
                                    });
                                  },
                                ),
                              ),
                              if (selectedCardCoverImageIdentifier ==
                                  currentCardCoverImageIdentifier)
                                const Center(
                                  child: Icon(
                                    Icons.done,
                                    size: 48,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: FilledButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    onPressed: () async {
                      await messageStoreModel.saveCardLimit(
                          widget.cardType,
                          widget.cardNumber,
                          int.parse(_cardLimitController.text.isNotEmpty
                              ? _cardLimitController.text
                              : "0"));
                      await messageStoreModel.saveCardCoverImage(
                          widget.cardType,
                          widget.cardNumber,
                          selectedCardCoverImageIdentifier);
                      goBack();
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save and Close")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
