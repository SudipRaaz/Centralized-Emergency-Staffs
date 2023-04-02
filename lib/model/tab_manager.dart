import 'package:flutter/material.dart';

class TabManager extends ChangeNotifier {
  //initial tab to open
  int selectedTab = 0;

  // updating the tab
  void goToTab(index) {
    selectedTab = index;
    notifyListeners();
  }
}
