import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/screens/cards_screen/cards/cards.dart';
import 'package:pay_tracker/screens/insights_screen/insights/insights.dart';
import 'package:pay_tracker/screens/payments_screen/payments/payments.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTabIndex = 1;

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
              Theme.of(context).colorScheme.surface, // Navigation bar
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
