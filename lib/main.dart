import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/constants/development_constants.dart';
import 'package:pay_tracker/screens/home_page/home_page.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  debugPaintSizeEnabled = useDebugBorders;
  runApp(
    ChangeNotifierProvider(
      create: (context) => MessageStoreModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: useDebugBanner,
      title: appName,
      theme: themeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}
