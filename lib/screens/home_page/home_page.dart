import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/constants/sms_reader_constants.dart';
import 'package:pay_tracker/screens/error_boundary/error_boundary.dart';
import 'package:pay_tracker/screens/message_list/message_list.dart';
import 'package:pay_tracker/screens/no_sms_access/no_sms_access.dart';
import 'package:pay_tracker/screens/progress/progress_loader.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/date_grouped_sms.dart';
import 'package:pay_tracker/types/displayed_sms.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';
import 'package:pay_tracker/utilities/readers/message_reader.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Exception exception = Exception('');
  bool smsPermissionFailed = false;
  bool exceptionOccurred = false;

  Future<void> messageMapper(List<InboxSmsMessage> inboxMessages) async {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context, listen: false);
    messageStoreModel.clearGroupedSms();
    List<DisplayedSms> displayedSms = [];
    for (var inboxMessage in inboxMessages) {
      RegExpMatch? regexMatch = regExp.firstMatch(inboxMessage.body);
      if (regexMatch != null) {
        displayedSms.add(DisplayedSms(regexMatch, inboxMessage));
      }
    }
    String? dateStamp = displayedSms.isNotEmpty
        ? displayedSms[0].dateTime.toString().substring(0, 10)
        : null;
    List<DisplayedSms> dateStampMessages =
        displayedSms.isNotEmpty ? [displayedSms[0]] : [];
    for (var i = 1; i < displayedSms.length; i++) {
      DisplayedSms sms = displayedSms[i];
      String currentDateStamp = sms.dateTime.toString().substring(0, 10);
      if (dateStamp == currentDateStamp) {
        dateStampMessages.add(sms);
      } else {
        messageStoreModel.addGroupedSms(DateGroupedSms(dateStampMessages));
        dateStamp = currentDateStamp;
        dateStampMessages = [sms];
      }
    }
    if (dateStampMessages.isNotEmpty) {
      messageStoreModel.addGroupedSms(DateGroupedSms(dateStampMessages));
    }
  }

  Future<void> fetchMessagesFromInbox() async {
    smsPermissionFailed = false;
    exceptionOccurred = false;
    List<InboxSmsMessage> inboxMessages = [];
    try {
      inboxMessages = await getInboxMessages();
    } on PlatformException {
      smsPermissionFailed = true;
    } on Exception catch (e) {
      exceptionOccurred = true;
      exception = e;
    }
    if (smsPermissionFailed || exceptionOccurred) return;
    await messageMapper(inboxMessages);
    await Future.delayed(const Duration(milliseconds: 100), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: FutureBuilder(
        future: fetchMessagesFromInbox(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const ProgressLoader();
          } else if (smsPermissionFailed) {
            return const NoSmsAccess();
          } else if (exceptionOccurred) {
            return ErrorBoundary(exception: exception);
          }
          return const MessageList();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Reload Messages',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
