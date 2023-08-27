import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/screens/error_boundary/error_boundary.dart';
import 'package:pay_tracker/screens/message_list/message_list.dart';
import 'package:pay_tracker/screens/no_sms_access/no_sms_access.dart';
import 'package:pay_tracker/screens/progress/progress_loader.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/types/inbox_sms_message.dart';
import 'package:pay_tracker/utilities/readers/message_reader.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context, listen: false);

    Exception exception = Exception('');
    bool smsPermissionFailed = false;
    bool exceptionOccurred = false;

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
      await messageStoreModel.addInboxMessagesToStore(inboxMessages);
      await Future.delayed(const Duration(milliseconds: 100), () {});
    }

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
    );
  }
}
