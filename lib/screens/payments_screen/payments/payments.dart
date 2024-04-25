import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/payments_screen/error_boundary/error_boundary.dart';
import 'package:pay_tracker/screens/payments_screen/message_list/message_list.dart';
import 'package:pay_tracker/screens/payments_screen/no_sms_access/no_sms_access.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:provider/provider.dart';

class Payments extends StatelessWidget {
  const Payments({super.key});

  @override
  Widget build(BuildContext context) {
    MessageStoreModel messageStoreModel =
        Provider.of<MessageStoreModel>(context);

    if (messageStoreModel.smsPermissionFailed) {
      return const NoSmsAccess();
    } else if (messageStoreModel.exceptionOccurred) {
      return ErrorBoundary(exception: messageStoreModel.exception);
    }
    return const MessageList();
  }
}
