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

  // text style
  TextStyle boldHeading =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  // text style
  TextStyle serviceTile = const TextStyle(fontSize: 20, color: Colors.white);

  //heading style
  TextStyle heading1 =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w700);
  TextStyle heading2 =
      const TextStyle(fontSize: 25, fontWeight: FontWeight.w500);
  TextStyle heading3 =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  TextStyle heading4 = const TextStyle(
    fontSize: 18,
  );
  //heading style
  TextStyle subText =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
  TextStyle subSubText = const TextStyle(
    fontSize: 16,
  );
}

class MyTextStyle {
  TextStyle profile_page_credentials = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
