import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/message_list/card_list.dart';
import 'package:pay_tracker/screens/message_list/empty_message_list.dart';
import 'package:pay_tracker/screens/spending_analytics/spending_analytics.dart';
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

    List<DateGroupedSms> messages =
        messageStoreModel.groupedMessages.length >= 10
            ? messageStoreModel.groupedMessages.sublist(0, 10)
            : messageStoreModel.groupedMessages;

    if (messages.isEmpty) {
      return const EmptyMessageList();
    }
    return Column(
      children: [
        // const SpendingAnalytics(),
        Expanded(
          child: ListView.builder(
            itemCount: messages.length + 1,
            itemBuilder: (BuildContext buildContext, int index) {
              int currentIndex = index - 1;
              if (currentIndex == -1) return const SpendingAnalytics();
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
                                messages[currentIndex].date,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                '#${index.toString()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ]),
                        messages[currentIndex].creditCards.isNotEmpty
                            ? CardList(
                                cards: messages[currentIndex].creditCards)
                            : const SizedBox(width: 0, height: 0),
                        messages[currentIndex].debitCards.isNotEmpty
                            ? CardList(cards: messages[currentIndex].debitCards)
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
