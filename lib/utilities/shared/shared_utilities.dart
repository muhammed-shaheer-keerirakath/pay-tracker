import 'package:flutter/material.dart';

String getThemeModeIdentifier(BuildContext context) {
  return (Theme.of(context).brightness == Brightness.dark) ? '_dark' : '_light';
}
