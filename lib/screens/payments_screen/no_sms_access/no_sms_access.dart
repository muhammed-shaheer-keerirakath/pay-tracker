import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/screen_display_text_constants.dart';

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
          children: [
            Icon(
              Icons.security_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 18,
            ),
            const Text(
              textAlign: TextAlign.center,
              noSmsAccessText,
            ),
          ],
        ),
      ),
    );
  }
}
