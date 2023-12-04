import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/screens/cards/cards.dart';
import 'package:pay_tracker/screens/insights/insights.dart';
import 'package:pay_tracker/screens/payments/payments.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  void _changeTabSelection(int indexKey) {
    setState(() {
      _selectedTabIndex = indexKey;
    });
  }

  static const List<Widget> _tabWidgets = [
    Insights(),
    Payments(),
    Cards(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarColor:
              Theme.of(context).colorScheme.background, // Navigation bar
        ),
        title: const Text(appName),
      ),
      body: _tabWidgets.elementAt(_selectedTabIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card_outlined),
            label: 'Cards',
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: _changeTabSelection,
      ),
    );
  }
}
