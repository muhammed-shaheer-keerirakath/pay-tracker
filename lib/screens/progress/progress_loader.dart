import 'package:flutter/material.dart';

class ProgressLoader extends StatelessWidget {
  const ProgressLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: const Center(
        child: SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator(
            strokeWidth: 8,
          ),
        ),
      ),
    );
  }
}
