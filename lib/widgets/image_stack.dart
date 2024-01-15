import 'package:flutter/material.dart';

class CustomRoundedCardOnImageStack extends StatelessWidget {
  final String text;
  final double? topPadding;
  final Color? cardColor;
  final Color? textColor;
  final double? elevation;

  const CustomRoundedCardOnImageStack({
    super.key,
    required this.text,
    this.topPadding,
    this.cardColor,
    this.textColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0.0),
      child: Card(
        elevation: elevation ?? 1.0,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, bottom: 7.0, top: 7.0),
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}