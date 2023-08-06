import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';

class EmptyMessageListSampleSms extends StatelessWidget {
  const EmptyMessageListSampleSms({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> messageSplit = smsLike.split('%');
    List<String> messageSampleVariables = smsLikeSampleVariables.split(' | ');
    List<TextSpan> textSpanMessages = [];
    for (var message in messageSplit) {
      if (message.isNotEmpty) {
        textSpanMessages.add(TextSpan(
          text: message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      }
      if (messageSampleVariables.isNotEmpty) {
        textSpanMessages.add(TextSpan(
          text: messageSampleVariables.removeAt(0),
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 12,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Icon(Icons.account_circle_outlined),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    smsAddress,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: textSpanMessages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
