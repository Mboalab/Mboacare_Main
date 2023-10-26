import 'package:flutter/material.dart';

class RandomColorAvatar extends StatelessWidget {
  const RandomColorAvatar(
      {super.key,
      required this.username,
      required this.avatarSize,
      required this.fontSize});
  final String username;
  final double avatarSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    List<Color> predefinedColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.deepPurple,
      Colors.cyan,
      Colors.indigo,
      Colors.lightGreen,
      Colors.deepOrange,
      Colors.brown,
    ];
    String firstLetter = username.isNotEmpty ? username[0].toUpperCase() : '';

    int colorIndex = username.isNotEmpty
        ? username.codeUnitAt(0) % predefinedColors.length
        : 0;

    return CircleAvatar(
      backgroundColor: predefinedColors[colorIndex],
      radius: avatarSize,
      child: Text(
        firstLetter,
        style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
