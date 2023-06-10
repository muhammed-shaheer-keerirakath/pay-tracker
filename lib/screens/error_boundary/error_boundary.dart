import 'package:flutter/material.dart';
import 'package:pay_tracker/constants/app_constants.dart';

class ErrorBoundary extends StatelessWidget {
  const ErrorBoundary({super.key, required this.exception});
  final Exception exception;

  @override
  Widget build(BuildContext context) {
    String errorText = '$errorBoundaryText\n\n${exception.toString()}';
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
            ),
            const SizedBox(
              height: 18,
            ),
            SingleChildScrollView(
              child: Text(
                errorText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
