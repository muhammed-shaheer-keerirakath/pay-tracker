import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';

class CardSettings extends StatefulWidget {
  const CardSettings({
    super.key,
    required this.cardNumber,
  });
  final String cardNumber;

  @override
  State<CardSettings> createState() => _CardSettingsState();
}

class _CardSettingsState extends State<CardSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitleCardSettings),
      ),
      body: Text(
        'card ${widget.cardNumber}',
      ),
    );
  }
}
