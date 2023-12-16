import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pay_tracker/constants/image_constants.dart';
import 'package:pay_tracker/screens/message_list/payment_card_content.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:provider/provider.dart';

class Cards extends StatelessWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);
    List<String> cardTypesKeys =
        messageStoreModel.cardTypesAndNumbers.keys.toList();

    return ListView.builder(
        itemCount: cardTypesKeys.length,
        itemBuilder:
            (BuildContext parentListViewBuildContext, int parentListViewIndex) {
          String cardType = cardTypesKeys[parentListViewIndex];
          List<String> cardNumbers =
              messageStoreModel.cardTypesAndNumbers[cardType] ?? [];

          String themeModeIdentifier =
              (Theme.of(context).brightness == Brightness.dark)
                  ? ThemeModeIdentifier.dark
                  : ThemeModeIdentifier.light;

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
                      '${cardTypesKeys[parentListViewIndex]}s',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    ListView.builder(
                        itemCount: cardNumbers.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext childListViewBuildContext,
                            int childListViewIndex) {
                          String cardNumber = cardNumbers[childListViewIndex];
                          String cardCoverImage =
                              messageStoreModel.getCardCoverImage(
                                  cardType, cardNumber, themeModeIdentifier);

                          return Card(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(cardCoverImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cardType,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      'XXXX $cardNumber',
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          );
                        }),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
