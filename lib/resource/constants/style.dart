import 'package:flutter/material.dart';

class MyStyle {
  // secondary buttons
  ButtonStyle elevatedButtonSecondary = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: const Color.fromARGB(137, 204, 204, 204));

  // primary buttons
  ButtonStyle elevatedButtonPrimary = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      backgroundColor: const Color.fromARGB(255, 76, 99, 250));
}

class MyTextStyle {
  TextStyle profile_page_credentials = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
