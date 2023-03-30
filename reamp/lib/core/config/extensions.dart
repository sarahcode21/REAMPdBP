import 'package:flutter/material.dart';

extension StringExtension on String {
  /// Returns a new capitalized instance of this string
  String capitalize() => isNotEmpty
    ? "${this[0].toUpperCase()}${substring(1)}"
    : '';
}

extension ColorExtension on Color {
  /// Darken a color by the given percentage
  Color darken(double percent) {
    assert(0 <= percent && percent <= 1);
    return Color.fromARGB(
      alpha,
      (red * percent).round(),
      (green * percent).round(),
      (blue * percent).round(),
    );
  }

  /// Lighten a color by the given percentage
  Color lighten(double percent) {
    assert(0 <= percent && percent <= 1);
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * percent).round(),
      green + ((255 - green) * percent).round(),
      blue + ((255 - blue) * percent).round(),
    );
  }
}
