import 'package:flutter/material.dart';

Widget blogTextFormField(
    String label, String hintText, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey, width: 1.0),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              border: InputBorder.none),
        ),
      )
    ],
  );
}
