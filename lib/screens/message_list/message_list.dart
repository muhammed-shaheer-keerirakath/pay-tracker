import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/message_list/card_list.dart';
import 'package:pay_tracker/screens/message_list/empty_message_list.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);

    List<DateGroupedSms> messages = messageStoreModel.groupedMessages;

    if (messages.isEmpty) {
      return const EmptyMessageList();
    }
    return Column(
      children: [
        // const SpendingAnalytics(),
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                messages[index].date,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                '#${(index + 1).toString()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ]),
                        messages[index].creditCards.isNotEmpty
                            ? CardList(cards: messages[index].creditCards)
                            : const SizedBox(width: 0, height: 0),
                        messages[index].debitCards.isNotEmpty
                            ? CardList(cards: messages[index].debitCards)
                            : const SizedBox(width: 0, height: 0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
