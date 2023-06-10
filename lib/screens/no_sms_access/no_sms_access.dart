import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';

class NoSmsAccess extends StatelessWidget {
  const NoSmsAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.security_outlined,
              size: 48,
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              textAlign: TextAlign.center,
              noSmsAccessText,
            ),
          ],
        ),
      ),
    );
  }
}
