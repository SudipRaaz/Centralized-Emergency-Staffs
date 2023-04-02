import 'package:ambulance_staff/view/dashboard_page.dart';
import 'package:ambulance_staff/view/history_page.dart';
import 'package:ambulance_staff/view/profile_page.dart';
import 'package:flutter/cupertino.dart';

class PageLists {
  static const List pages = <Widget>[
    DashboardPage(),
    HistoryPage(),
    ProfilePage()
  ];
}
