import 'package:ambulance_staff/model/tab_manager.dart';
import 'package:ambulance_staff/resource/constants/pages_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List pages = PageLists.pages;

    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
          body: pages[tabManager.selectedTab],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabManager.selectedTab,
            //change the body based on the index of the bottom navigation tap
            onTap: (index) {
              tabManager.goToTab(index);
            },
            fixedColor: Colors.black,
            backgroundColor: Color.fromARGB(115, 248, 248, 248),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ));
    });
  }
}
