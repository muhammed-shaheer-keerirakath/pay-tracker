import 'package:flutter/material.dart';
import 'package:pay_tracker/screens/spending_analytics/spending_analytics.dart';

class Insights extends StatelessWidget {
  const Insights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [SpendingAnalytics()],
    );
  }
}
