import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pay_tracker/constants/app_constants.dart';
import 'package:pay_tracker/constants/development_constants.dart';
import 'package:pay_tracker/screens/home_page/home_page.dart';
import 'package:pay_tracker/stores/local_store_model.dart';
import 'package:pay_tracker/stores/message_store_model.dart';
import 'package:pay_tracker/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  if (useDebugBorders) {
    debugPaintSizeEnabled = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalStoreModel>(
          create: (_) => LocalStoreModel(),
        ),
        ChangeNotifierProvider<MessageStoreModel>(
          create: (_) => MessageStoreModel(),
        ),
      ],
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
