import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/payments_screen/message_list/card_list.dart';
import 'package:pay_tracker/screens/payments_screen/message_list/empty_message_list.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: messageStoreModel.monthsList.map((monthAndYear) {
          List<DateGroupedSms> messagesDuringTheMonth = messages
              .where(((message) =>
                  '${message.month} ${message.year}' == monthAndYear))
              .toList();

          return ExpansionTile(
            title: Text(monthAndYear),
            initiallyExpanded:
                monthAndYear == messageStoreModel.selectedMonthAndYear,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: messagesDuringTheMonth.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    messagesDuringTheMonth[index].date,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ]),
                            messagesDuringTheMonth[index].creditCards.isNotEmpty
                                ? CardList(
                                    cards: messagesDuringTheMonth[index]
                                        .creditCards)
                                : const SizedBox(width: 0, height: 0),
                            messagesDuringTheMonth[index].debitCards.isNotEmpty
                                ? CardList(
                                    cards: messagesDuringTheMonth[index]
                                        .debitCards)
                                : const SizedBox(width: 0, height: 0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
