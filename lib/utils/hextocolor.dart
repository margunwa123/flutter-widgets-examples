import 'package:flutter/material.dart';

extension StringExtensions on String {
  Color hexToColor({
    Color? defaultColor,
  }) {
    final buffer = StringBuffer();
    try {
      if (length == 6 || length == 7) buffer.write('ff');
      buffer.write(replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return defaultColor ?? Colors.transparent;
    }
  }
}
