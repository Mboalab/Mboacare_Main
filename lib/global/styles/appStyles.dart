import 'package:flutter/material.dart';

class AppTextStyles {
  static get headerOne =>
      const TextStyle(fontSize: 42, fontWeight: FontWeight.w700);
  static get headerTwo => const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 28,
      );
  static get headerThree =>
      const TextStyle(fontWeight: FontWeight.w800, fontSize: 24);
  static TextStyle get bodyOne => const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );

  static TextStyle get bodyTwo => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
      );
  static TextStyle get buttonText => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      );

  static TextStyle get bodyThree => const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 14, height: 18 / 14);

  static TextStyle get bodyFour => const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      );
}

const double iconSize = 24.0;
