import 'dart:math';

import 'package:flutter/material.dart';

class DataRowItem extends StatelessWidget {
  const DataRowItem({
    required this.data,
    required this.title,
    super.key,
    this.hasBottomSpacing = true,
    this.progressDinominator = 0,
    this.progressNumerator = 0,
    this.secondaryData = '',
    this.shouldHide = false,
  });
  final bool hasBottomSpacing;
  final bool shouldHide;
  final double progressDinominator;
  final double progressNumerator;
  final String data;
  final String secondaryData;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (shouldHide) return Container();

    double percentage = progressNumerator / progressDinominator;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              fontSize: 12),
        ),
        Row(
          children: [
            Text(
              data,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            if (secondaryData.isNotEmpty)
              Text(
                secondaryData,
              ),
          ],
        ),
        if (progressDinominator > 0)
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: LinearProgressIndicator(
                    value: percentage,
                    semanticsLabel: 'Linear progress indicator',
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                  flex: 1,
                  child: Text(
                      '${(min(percentage * 100, 100)).toStringAsFixed(2)}%')),
            ],
          ),
        if (hasBottomSpacing)
          const SizedBox(
            height: 4,
          )
      ],
    );
  }
}
